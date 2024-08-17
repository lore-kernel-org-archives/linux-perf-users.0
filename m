Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917A7DA97;
	Sat, 17 Aug 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897335; cv=none; b=dSdpVuSk2H9HY3Q8kgo+hmaapt5/oMXkaXGMzOLlW63ENcCfXvhgLhlXhipT+hJboPU+yMoHKaXjS9hkJFtWrsGf6UIdpdu5EJg6si/GQNx/uddheRhbaQt+4Rx9ii+RQjtpai5GuUggM5EoULhCVJ8BtY5atxnA6l0ZWc0q5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897335; c=relaxed/simple;
	bh=j+kK/b6pBwqtHra2GIarQFWh132XpgrW+BqMkYbIXig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WhkJhkd2DSyvy+8IO1b0QOmi19q5JkxISjdjVHHBmlASGd0UiDr+/ttYw+i4kgZrJV2Jls7uOdRkXQNbqjcyeM+sXCFPflE+ITYIWWQJXPAdTs/zcVpQyil76pvZ+T+QCst+UO7oX4xpKhqupf5pBKKFg66DlXPpgwGMJFQu3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llvI+OzO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llvI+OzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723897334; x=1755433334;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=j+kK/b6pBwqtHra2GIarQFWh132XpgrW+BqMkYbIXig=;
  b=llvI+OzOIC0wxPZe0MceZJctb3zZyKAGvsOtLj6LKrWgQmcCzONcnv+I
   nVxm8uZaHvaAoLh2NnwyygXgMAEQbUVMu/ngZts5NgfoxpyXJ8kKo8eYV
   GHP6hgHFBoJSZJKEsiTDsgqtaZkiasW4lT7UnA5wAUDVjExJwbKwVLCIM
   mUIadmeDlV6lZUX2Jz1LXtLrp+l5gSa1ZpsZ0rNfQH6VAV2QCzPMlyJEf
   0oHTJzXEU+ZeqkJd2PefWixSDfMZUcXpolveJlOktVDKt26iR9/l+8mnk
   UtJxuzbdKddgPbB5bRqxJK17l1XfOYSEWHQ+Igi8sMvfkm/cCR0Kf8Yqs
   w==;
X-CSE-ConnectionGUID: LXGaHZIKSYuKIoB7h2qjTg==
X-CSE-MsgGUID: BE5VvK77RfanmXJfgRiGUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="21814000"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="21814000"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 05:22:13 -0700
X-CSE-ConnectionGUID: RZLSlPiUSbunEEV04rgjPA==
X-CSE-MsgGUID: hvYQWV9GS0uVO/itomCosQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="59959602"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 05:22:13 -0700
Received: from [10.212.114.32] (kliang2-mobl1.ccr.corp.intel.com [10.212.114.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B9B1020CFED8;
	Sat, 17 Aug 2024 05:22:10 -0700 (PDT)
Message-ID: <4a2761ee-1e6a-4d8a-b228-0702c11b7ea9@linux.intel.com>
Date: Sat, 17 Aug 2024 08:22:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com> <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com> <87wmkhlk1l.ffs@tglx>
 <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com> <87plq9l5d2.ffs@tglx>
 <705dc2fe-7ab3-458a-9b5a-7ea0b30756b8@linux.intel.com>
Content-Language: en-US
In-Reply-To: <705dc2fe-7ab3-458a-9b5a-7ea0b30756b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-16 3:27 p.m., Liang, Kan wrote:
> The HSW11 is also BDM11. It sounds like we need the trick from both bdw
> and nhm.
> 
> How about this?
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e8bd45556c30..42f557a128b9 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4664,6 +4664,12 @@ static void nhm_limit_period(struct perf_event
> *event, s64 *left)
>  	*left = max(*left, 32LL);
>  }
> 
> +static void hsw_limit_period(struct perf_event *event, s64 *left)
> +{
> +	nhm_limit_period(event, left);


Sigh, apparently, I used an old specification update (Rev 003) for HSW.
It claims that the BDM55 is also applied to HSW (HSW75).
https://www.mouser.com/pdfdocs/xeone31200v3specupdate.PDF
So I thought the nhm_limit_period() should be used for HSW as well.

However, a newer version (Rev 016) deleted the HSW75 for HSW.
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e3-1200v3-spec-update-oct2016.pdf

Yes, as you suggested, something as below is required.


diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e8bd45556c30..b22a4289553b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4634,6 +4634,17 @@ static enum hybrid_cpu_type
adl_get_hybrid_cpu_type(void)
 	return HYBRID_INTEL_CORE;
 }

+static inline bool erratum_hsw11(struct perf_event *event)
+{
+	return (event->hw.config & INTEL_ARCH_EVENT_MASK) ==
+		X86_CONFIG(.event=0xc0, .umask=0x01);
+}
+
+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	*left = max(*left, erratum_hsw11(event) ? 128 : 32);
+}
+
 /*
  * Broadwell:
  *
@@ -4651,8 +4662,7 @@ static enum hybrid_cpu_type
adl_get_hybrid_cpu_type(void)
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
-			X86_CONFIG(.event=0xc0, .umask=0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
@@ -6821,6 +6831,7 @@ __init int intel_pmu_init(void)

 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
+		x86_pmu.limit_period = hsw_limit_period;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
Thanks,
Kan

> +	bdw_limit_period(event, left);
> +}
>  static void glc_limit_period(struct perf_event *event, s64 *left)
>  {
>  	if (event->attr.precise_ip == 3)
> 
> Do you plan to post the "limit" patch for HSW?
> Or should I send the patch?
