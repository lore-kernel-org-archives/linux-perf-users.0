Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A2C5479D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 07:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjAIHCL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 02:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjAIHCK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 02:02:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0285FAE
        for <linux-perf-users@vger.kernel.org>; Sun,  8 Jan 2023 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673247729; x=1704783729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rM7J2uzufP+jZ+wN2jsU5j3kMbDS4MhQgn1jncER2k0=;
  b=a8BjFn4inr/iiFuBJEwveHu6DtEwiN09+xe28H9jbICtYTBsToReu2aQ
   4Ss42NKbaQq3zFGVJA/xNbbYlHX/+6ay4OOpDA5xxjgCI2S2phJ0tkgEN
   EfM3aqlZH86UgOwnY+el1E/efGKVoxiqhKuJ89ErdsH/shBA8+NH/DzU7
   fqiTkfMcgIoVmQl0S6ouIzJpEY6zc7RzTBTX+W8HXNUYHZe6IlKZ84HLr
   t8+Zt36pC358RmelWCWRpdb5rFcgn7lCeF/EZSdbXpTyUfSOu/Q4QbPnt
   waVFkju6AEGtG3AyRkftht9Uw6n0OZsvVukJasgpHpCexN8zhguQGMkf3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="385109666"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385109666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:02:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="830498656"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="830498656"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:02:07 -0800
Message-ID: <aad6782c-fb30-ba39-ba59-775c5f227d56@intel.com>
Date:   Mon, 9 Jan 2023 09:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1] perf record: Correct address filters for
 duplicated symbols
To:     Dmitrii Dolgov <9erthalion6@gmail.com>,
        linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        irogers@google.com
References: <20230106203751.403270-1-9erthalion6@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230106203751.403270-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/01/23 22:37, Dmitrii Dolgov wrote:
> It seems the logic to handle duplicated symbols is off. In case if the
> symbol index is specified it will:
> 
> * find a match
> * continue searching
> * check that start is not null and idx is set on the next loop
> * exit with the error code 1
> 
> My guess is the expectation was that at this point the second match is
> found (because *start is not null), although the new symbol hasn't pass
> dso_sym_match yet. Here is how it looks like:

If *start && idx > 0 there is no need to match anymore.  The
code is just getting *size.  Looks to me like it should be:

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 265d20cc126b..c2e323cd7d49 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 				*size = sym->start - *start;
 			if (idx > 0) {
 				if (*size)
-					return 1;
+					return 0;
 			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
 				print_duplicate_syms(dso, sym_name);
 				return -EINVAL;


> 
>     $ readelf -a postgres | grep simple_heap_update
>         4716: 00000000004e23e5   352 FUNC    GLOBAL DEFAULT   13 simple_heap_update
>         27829: 00000000004e23e5   352 FUNC    GLOBAL DEFAULT   13 simple_heap_update
> 
>     $ perf record -p <pid> -e intel_pt// \
>         --filter 'filter simple_heap_update #1 @ postgres' -- sleep 60
> 
>         Failed to parse address filter: 'filter simple_heap_update #1 @ postgres'
>         Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
>         Where multiple filters are separated by space or comma.
> 
> Correct by returning error only after checking whether the symbol is
> matching or not. After modifications the case above seems to be working
> as expected:
> 
>     $ perf record -p <pid> -e intel_pt// \
>         --filter 'filter simple_heap_update #1 @ postgres' -- sleep 60
> 
>     # update heap a couple of times
> 
>     $ perf script --itrace=c
> 
>         branches: 4e23fe simple_heap_update+0x19 => 54829c GetCurrentCommandId+0x0
>         # [...]
>         branches: 4e23fe simple_heap_update+0x19 => 54829c GetCurrentCommandId+0x0
>         # [...]
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  tools/perf/util/auxtrace.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b59c278fe9ed..112cef56d6c2 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2593,15 +2593,23 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
>  
>  	sym = dso__first_symbol(dso);
>  	while (sym) {
> +		/* Verify duplicates if one match was already found */
>  		if (*start) {
>  			if (!*size)
>  				*size = sym->start - *start;
> -			if (idx > 0) {
> -				if (*size)
> -					return 1;
> -			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
> -				print_duplicate_syms(dso, sym_name);
> -				return -EINVAL;
> +
> +			if (dso_sym_match(sym, sym_name, &cnt, idx)) {
> +				if (idx > 0) {
> +					/*
> +					 * There is already one match with the specified index, now
> +					 * we found the second one, something is wrong.
> +					 */
> +					if (*size)
> +						return 1;
> +				} else {
> +					print_duplicate_syms(dso, sym_name);
> +					return -EINVAL;
> +				}
>  			}
>  		} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
>  			*start = sym->start;

