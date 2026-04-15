Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE7313532;
	Wed, 15 Apr 2026 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220263; cv=none; b=Nz2OWSWua6TmGreG/QwHUkdnOiFihwiRdvxEt7X+EMm3GqP41Dn2ITFWEaotvby++KKdC4pkIhlkoS9TXC4aA+12ZOnSLnu8PBOia73ZJ7cqWMfNRD3229OWrjILtFAUowaoPrR7MMk431vs4MJ4126ZlO9wfm29pvaUGeV5sIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220263; c=relaxed/simple;
	bh=rwxPUZWr3F6CcfD8tbD0wYumN/wPZ2XMt/5VNCngocU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH/D1haDzOq+aglOTXp8WCTp5F4iQuR9CtOp6AQJhJyl0C6c/II4YaNPuP5efMmwpJ8KELN8swPJ0O7rkdYZ4HMSSRWTC+3NyReopmFRUP2VkpS6/oyyOpBVPK2yZSauoz3OyBIVA2w9rIE8VoYRADyip+haRdVrSqIZTj2mVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOmtwTg5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOmtwTg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776220260; x=1807756260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rwxPUZWr3F6CcfD8tbD0wYumN/wPZ2XMt/5VNCngocU=;
  b=HOmtwTg5GO+8YLIvdZW/DYYLO3mfY8kSU5wzeUdZfbMDcmR/Wj0g/PiG
   dbxALUrSN/KQi9BJxNSZobvb7RzebMIfpDvk+ogruKlC10T+enD0zAyE0
   y1J8Y7wVfmhIcdYC31k96g1T9FbezOO0MDkgmYbMEBNP2HSUW6ByTAlMP
   lKAYciluM0oCSoRTbYcPsxBP2ZXjjc6P3g0NRtqEcWND7opCK5fH/gMaW
   Nr9im5WwhRxQqItX0wIU45du7YbIwwqiGiFmAHKfPIrSCLP+Lj9KNg0Z/
   6KzdX1pE72x4N+/lvuADC6ufDiHKnPfEK1arsL3GL1Ig1qeD5vAIYnghr
   A==;
X-CSE-ConnectionGUID: Ka9h/StJQ+Wc6UxOF711pQ==
X-CSE-MsgGUID: hPyXpumIQpahunwNTYq/KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="80786903"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80786903"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 19:30:59 -0700
X-CSE-ConnectionGUID: +RWGll5mQU2zbr2Vxcz2sA==
X-CSE-MsgGUID: EpjSQbkMSoeeu1A+zTLRBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227091873"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 19:30:29 -0700
Message-ID: <4a8a58c2-36d3-483a-bca0-5c414d4bf7ab@linux.intel.com>
Date: Wed, 15 Apr 2026 10:30:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/annotate: Fix missing branch counter column in
 TUI mode
To: Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260410194000.219846-1-thomas.falcon@intel.com>
 <20260410194000.219846-2-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260410194000.219846-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/11/2026 3:40 AM, Thomas Falcon wrote:
> perf annotate checks that evlist->nr_br_cntr has been incremented
> to determine whether to show branch counter information. However,
> this data is not populated until after the check when events are
> processed. Therefore, this counter will always be less than zero
> and the Branch Count column is never shown. Do this check after
> events have been processed and branch counter data is updated.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/builtin-annotate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 5e57b78548f4..7fe23b05306f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -563,6 +563,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  	if (ret)
>  		goto out;
>  
> +	if (session->evlist->nr_br_cntr > 0)

Do we need to check if annotate.has_br_stack is true before setting
show_br_cntr to true? Thanks.


> +		annotate_opts.show_br_cntr = true;
> +
>  	if (dump_trace) {
>  		perf_session__fprintf_nr_events(session, stdout);
>  		evlist__fprintf_nr_events(session->evlist, stdout);
> @@ -928,8 +931,6 @@ int cmd_annotate(int argc, const char **argv)
>  	 */
>  	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
>  		sort__mode = SORT_MODE__BRANCH;
> -		if (annotate.session->evlist->nr_br_cntr > 0)
> -			annotate_opts.show_br_cntr = true;
>  	}
>  
>  	if (setup_sorting(/*evlist=*/NULL, perf_session__env(annotate.session)) < 0)
