Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0831FCB
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLPtjJej"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA97D9B;
	Thu,  9 Nov 2023 22:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598826; x=1731134826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GFByGsB1s+0PGU3t69+rO9QyXyyNqEjugH1oc57Etf8=;
  b=YLPtjJejo6oJTnbTH+I2b1O+03MwHiEEJqW+MCh/S/+jqcpjwKjiQ8Il
   hXWoBgDBmif7Sp7cAdyBjGdHIXMfsZFA/n0sMbA9wmgg29eSOnBO7N+Qu
   CwGVJN047PwGSoXZWbigiIP5vGPCsBqIsH8i7zRfqlFlQ2+yIuxe3Fa7C
   83hb4DljZMMaFX3sJBkQ0551sF8cmfBTq+07V8yKgAFX0zW8cjE0jQerJ
   pSe+kv66S7dhDXMLuGs4f0fRjhR93q/zIvZdKoD071QlxKCtjNo6YAaPH
   AWeXlDv2PVain9PjfKeKvzNlIsL8UIwoemi8S2zZl65UywJtRZKReInPI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456639747"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456639747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010872445"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1010872445"
Received: from akoska-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:23:45 -0800
Message-ID: <5b467b4a-f58e-4fb2-a3d7-0f5b5297b866@intel.com>
Date: Fri, 10 Nov 2023 08:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: Disable __packed attribute compiler warning
 due to -Werror=attributes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <ZU04q6UZvbJn8OoT@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZU04q6UZvbJn8OoT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/23 21:53, Arnaldo Carvalho de Melo wrote:
> Noticed on several perf tools cross build test containers:
> 
>   [perfbuilder@five ~]$ grep FAIL ~/dm.log/summary
>     19    10.18 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
>     20    11.21 debian:experimental-x-mips64  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
>     21    11.30 debian:experimental-x-mipsel  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
>     37    12.07 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
>     42    11.91 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
>     44    13.17 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
>     45    12.09 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
>   [perfbuilder@five ~]$
> 
>   In file included from util/intel-pt-decoder/intel-pt-pkt-decoder.c:10:
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le16':
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
>      13 |         const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
>         |                             ^
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:28: note: in expansion of macro '__get_unaligned_t'
>      27 |         return le16_to_cpu(__get_unaligned_t(__le16, p));
>         |                            ^~~~~~~~~~~~~~~~~
> 
> This comes from the kernel, where the -Wattributes and -Wpacked isn't
> used, -Wpacked is already disabled, do it for the attributes as well.
> 
> Fixes: a91c987254651443 ("perf tools: Add get_unaligned_leNN()")
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/7c5b626c-1de9-4c12-a781-e44985b4a797@intel.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/include/asm-generic/unaligned.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
> index 156743d399aed223..2fd551915c2025ee 100644
> --- a/tools/include/asm-generic/unaligned.h
> +++ b/tools/include/asm-generic/unaligned.h
> @@ -8,6 +8,7 @@
>   */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wpacked"
> +#pragma GCC diagnostic ignored "-Wattributes"
>  
>  #define __get_unaligned_t(type, ptr) ({						\
>  	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\

