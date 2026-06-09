Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428C411681
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041858; cv=none; b=unUNv8cHbQmk+L1V5IqC0ZZevgsERU1ce4vxhZ9QQtHkKmMIAbpeaNIMXdbt4tmedzwUN7fWuE9rrLFIv4S/8mtFcG+1U4zDaOV+AUGsLZiEM22O7wPZ418DFd5kkQnWtspk9a/5Q8wTa5Xtq97F1Sb5uVTVK+fDsO0u7IXSKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041858; c=relaxed/simple;
	bh=7rjaisMtTiIAmR/4yF5YpDp1n1BrI85o2pa0Ragh074=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qs4b+3ioc30GWHadW5MRxeDFZyuDSTy5AP+33ScPlQa3I0rIcqOM7SGGBaL0B+t5r/Gz/QxXEJB82EANQE37vKXfODWtESo/vbEooPnYjLNv2Nwoxuu8jBdcRTBKhW5HGCAGi0qs85w5XUFUTztNqARRsZ7hqM2xcjNQTQC44ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+rZ/bN3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+rZ/bN3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so4373020a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041857; x=1781646657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgVtMxeTabi2qa/uRjh4m4K8g73Uf+vTYDmsLtwzKZU=;
        b=i+rZ/bN3iHPVc1NRAyQa+0biOdU18nJG/9HARnkXfjwi7r7bXdgmePOmAUzuQUkGco
         xkZEOpE/HKhl9awP3YVAOBxZbW7TU8awcIhzaqPY3yhTzL6FQ67bdcibGd8FikL5NI/k
         yUV+Z+MM28IbkSMDhGZovL/DRly+Yw0/lSCVTlyeU5NzpdQjzyV8Cb931Yk3PWNqXUza
         K28AS13sBRfr1lgylOsU7pyy3VRQJoDJy6odTRpSjA0IRI4uSdr6gICwHcxHCHwugOxx
         0LNVooyRBI6P7yJsn9EqWu4S8Ah75CphJryibsnh3NCgtMvkm1o1fSbLEBjndIKbiKyh
         UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041857; x=1781646657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgVtMxeTabi2qa/uRjh4m4K8g73Uf+vTYDmsLtwzKZU=;
        b=nQaL3Ve8UVSAwxcW0LNJ7X+Ee5r+8rQ9NwQ4TYqo/lDM9ZA7HfmohKQEIbhA6a0JPN
         0tDSco1CtN2moiIguSn/wTyT+YdUA1crL7NZnuJBR6QOqmIOhlz5SUsGzdm1lOMVtgqh
         xPS4+cbOdhHFV1BrNSOthntlJsoPPS/9cAFaiIB1dcFJj2I8gX5B40vdQmPv15EZaunj
         pkxtQt51dgGrrFj3pg2rHOT/FtNnIwTYfc3Im4wqrhhdSXuSMw01Pd9+5gVc89lO9N/q
         T/Z1N5R2knmI0Epm9FlObDkUDIIgUH5G1ESfZTYyG+38iK/sj86iWI8gKi8SNTEQ01iq
         tKVg==
X-Forwarded-Encrypted: i=1; AFNElJ8UZx4gcErY6BnNzoPKBGrING7Tg4a+fs3z8IzG8boEWptxUIIziWhRfPo65jJaD1xJOTMiWSi9OQvfFsiO8jrK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk82aRf1VYdIeMqyz0kCaSN4RGFw8olMek0i8rTWJthEpF7icP
	Pkeid32IiS8GJ4oKYpSA6EIl+YvmGxdHOkT50bxtME+sqD37hecWkFCoKJXjhVvH4sngyOdR7oF
	vdosQeA==
X-Received: from pjbfu17.prod.google.com ([2002:a17:90a:d191:b0:369:1a1a:82d6])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1642:b0:369:7421:75cf
 with SMTP id 98e67ed59e1d1-370f0284a7bmr20878362a91.16.1781041856338; Tue, 09
 Jun 2026 14:50:56 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:45 -0700
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-7-ctshao@google.com>
Subject: [PATCH v1 6/6] perf vendor events intel: Update tigerlake events from
 1.18 to 1.19
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/8353ffb63efcad6b6fac1a8c05d76e2d6317ae23

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 6af3cee12c8a..a7f870669827 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -35,7 +35,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
-GenuineIntel-6-8[CD],v1.18,tigerlake,core
+GenuineIntel-6-8[CD],v1.19,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
-- 
2.54.0.1099.g489fc7bff1-goog

