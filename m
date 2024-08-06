Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46680043;
	Tue,  6 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980043; cv=none; b=V5s9z7OrTTg2Dz3vJYJdqKwPijTqSt8EVQgFZiFp4bqrtc3MIWy2IG3HUONSB0nP5fcZZJNQ6ceaM2vQ6UQv1Jdo7+DK+VUxGCY0SzsXkV9c/TYAoCiVB7hkeUv0ag8CBkeiK16+9uzga9YHWC+ChDZ7ByJfn9+kXQbGQs6IoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980043; c=relaxed/simple;
	bh=DO8014anKApOwesYndEPWUGjEgeA57oZZUbqUPxyvv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=curCeyw/RZjSazHB/XGdTJEYhRQD8hQy/FYGDjtKleFFKJKgRvqb3VxoCPZhpnHBRmad+Y1RkkG+k70RwGw5wdB+tx1zCJdZtfyWwLqNDEsW9iNK1ubhVytA54eRAPrbRYGo2oBEGH6oYiSPmHsdjgV0sKJd/Z8Jbw5J+B7A2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B217EFEC;
	Tue,  6 Aug 2024 14:34:26 -0700 (PDT)
Received: from [10.57.79.15] (unknown [10.57.79.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1823F5A1;
	Tue,  6 Aug 2024 14:33:58 -0700 (PDT)
Message-ID: <a3699fc9-059f-4192-b522-918952c4b264@arm.com>
Date: Tue, 6 Aug 2024 22:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf dwarf-aux: Fix build fail when
 HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
To: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-4-yangjihong@bytedance.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240806114801.1652417-4-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2024 12:48 PM, Yang Jihong wrote:
> commit 3796eba7c137 move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> code from dwarf-aux.c to dwarf-aux.h, in which die_get_var_range() used ENOTSUP
> macro, but dwarf-aux.h was not self-contained and did not include file errno.h.
> 
> As a result, the build failed when HAVE_DWARF_GETLOCATIONS_SUPPORT macro was not
> defined, and the error log is as follows:
> 
>   In file included from util/disasm.h:8,
>                    from util/annotate.h:16,
>                    from builtin-top.c:23:
>   util/dwarf-aux.h: In function 'die_get_var_range':
>   util/dwarf-aux.h:184:10: error: 'ENOTSUP' undeclared (first use in this function)
>     184 |  return -ENOTSUP;
>         |          ^~~~~~~
>   util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears
> 
> Fixes: 3796eba7c137 ("perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/util/dwarf-aux.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 24446412b869..d2903894538e 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -5,6 +5,7 @@
>   * dwarf-aux.h : libdw auxiliary interfaces
>   */
> 
> +#include <errno.h>
>  #include <dwarf.h>

Please alphabet ordering. With it:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
> --
> 2.25.1
> 
> 
