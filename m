Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388E12FB13;
	Thu, 18 Jul 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322201; cv=none; b=jzRhYba0YgJ4x1CJekPi83qfHzWIFNEKUW2Wu5sPGVNmEldMDxpXYquqGsPLZVWutFlWciwm7E+Zr5MIDbBszaHlBQqt3jfRjJb5zA44pc4DH1ZmlxnWpyHbcwM/rCWjEMH3stP0xVkLVrrPPnlQLtno1IiHX4UDNuhy6nULx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322201; c=relaxed/simple;
	bh=kXuz3qRFrW50MAZWB/izpJVzaQHmcV5FvcpcNWcO9Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDiM7rJ1B8z5LtqJNlmGuEUo8qGaYn/2teR4zpPpKffGXKBEvEyIUdGZmd4WVf3xgh5qNObNYSSLIKwft+G1J1NiXQsfeI1zwJarzjTQnT46CgKgl6anAWdwKiC2/4Ft/oN/GkMmGyij+XfB8OpMaEMBERI10kkvydILudyESTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWeTvEng; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWeTvEng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721322199; x=1752858199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kXuz3qRFrW50MAZWB/izpJVzaQHmcV5FvcpcNWcO9Gk=;
  b=aWeTvEngemj7FSG9j7/PoJSxow5JSGhJ9TcIr2k+TvYNikvLY1ippzE6
   Ekf1BWOn0YQaQmHflJ19UaR/aZfVBuodehbLPPh8em7CQRb5S99/BngsN
   nR0DdF5M/4gL4Ehw1nue2u7w2MCBzCdk1x57NnghqpaEkL8TmF6SAaZBT
   RV4nk3vmM5Ci2gLXXEE/fO1RfcWfPPklZJkBa9+CSmVI5whsn6aUANFMY
   GcA2DoG81AfoLK4MQMr5ETe00EwMBJBcYHv+z/4mOTO8qyrFqDof5krN5
   P6xa/ndHtWvWK4e7oDt8EZaf6u6yD8JJvNMIWK26n/jZAIx1130HEdaw+
   A==;
X-CSE-ConnectionGUID: euBlAwoPSm24iHNLfkTgcg==
X-CSE-MsgGUID: fs+ajowtS52kT+1py794Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="12611807"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="12611807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:03:18 -0700
X-CSE-ConnectionGUID: SiojpKQkS3OAeUhQKLHs9A==
X-CSE-MsgGUID: xB6c0hV4RzGi/CzTvoZtZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="88321245"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:03:13 -0700
Message-ID: <14afba8e-cb85-4d7d-96e4-d65fd8ebc2d5@intel.com>
Date: Thu, 18 Jul 2024 20:03:07 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] perf: build-id: name debugging vdso as "debug"
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-5-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240702041837.5306-5-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/07/24 07:18, Changbin Du wrote:
> As normal objects, we will add debugging vdso elf to build-id cache later.
> Here we name the debugging one as "debug".
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/build-id.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 83a1581e8cf1..15530af2bad9 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -259,8 +259,8 @@ static bool build_id_cache__valid_id(char *sbuild_id)
>  static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
>  					    bool is_debug)
>  {
> -	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
> -	    "debug" : "elf"));
> +	return is_kallsyms ? "kallsyms" : (is_debug ? "debug" : (is_vdso ?
> +		"vdso" : "elf"));
>  }
>  
>  char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,

To actually add "debug", this also needs:

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 15530af2bad9..b5bd02a1ad0f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -701,7 +701,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 	 * file itself may not be very useful to users of our tools without a
 	 * symtab.
 	 */
-	if (!is_kallsyms && !is_vdso &&
+	if (!is_kallsyms &&
 	    strncmp(".ko", name + strlen(name) - 3, 3)) {
 		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
 		if (debugfile) {



With that perf will populated the "debug" entry in the build-id cache.
Currently, when adding to the build-id cache, perf only looks in
/usr/lib/debug/.build-id (refer build_id_cache__find_debug()), for
example:


$ sudo ln -s /lib/modules/6.9.2-local/build/arch/x86/entry/vdso/vdso64.so.dbg /usr/lib/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.debug
$ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
total 8
-rw-r--r-- 1 ahunter ahunter    0 Jul 18 13:33 probes
-rw------- 1 ahunter ahunter 8192 Jul 18 13:33 vdso
$ perf record uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.010 MB perf.data (2 samples) ]
$ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
total 40
-rwxrwxr-x 2 ahunter ahunter 32760 May 27 17:42 debug
-rw-r--r-- 1 ahunter ahunter     0 Jul 18 13:33 probes
-rw------- 1 ahunter ahunter  8192 Jul 18 13:33 vdso


Note, perf will anyway find the debug object in /usr/lib/debug/.build-id
so the benefit is if perf-archive is used to copy from the buildid-cache
to take to another machine.

