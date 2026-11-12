Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527447;
	b=5R0cdhQOj936BGCcS51bQPQtFoY1EJ/VcJlo191Po8A62jARNFZuCZA6U2gfm43bUxjW
	 QYl8ov+1sMu6o07Ua7DqWPbcBbVPp7bIcU3bhld25HX5WzOP04EDvfILThcvS1wySC8M0
	 eeLrRcYUAsKE/t29TLOPfbzPNmiz/JXPK/U0zoavxli+0lvYZ5PmalBi9zFGVVWe3VkyO
	 6QpfxF8IjacwTmz6A/0VdsGsL9s5j32RODq9X7LJfGBa1oGnut/A+auFVEyHZRpszFYVL
	 Xmb7gfAwSElLeD5tyh4V8bAnXgy3y2ou24ug65nzg1ofvBr1g0zliv26Yaz/eyXKYyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mczvvyy/drg/WCTWwSqRdjrsqzKouaYUkQ4KLSPDcJ8=;
	b=rgvS3LuFuDOxlEe67sMllmyIt32/SHUSb4p7gWC3N856aYA6ArC+yITvr35Ty2TmGt06
	 XtS/Hf8a0lSTXi7oeMPuhdS0KRu8fPC9fzI8ORoCTKuW6d6E1shHEvpDYcavOyfc7htTY
	 SiiH7nGTECU5sOFNcRnTxWvlaOD1F+9RDnNtLNxmVtsR8iQXn+KOaMTJQe8soyBt3+1R2
	 vfEePLHJsR6GTmkKdatkHyB/7RQaV0ArPDd2n/c2w+wpoobTRTfElM/3RdgftzWaMxfk3
	 kG62tRl9j7cCYp7S4C3UnFYfTe1F6x6HAClFn9qv9kM5mH9nDo1O7QThAKT0i2BX8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuxAfrML;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E77606A883
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E77606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuxAfrML
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so417623c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794527446; x=1795132246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mczvvyy/drg/WCTWwSqRdjrsqzKouaYUkQ4KLSPDcJ8=;
        b=tuxAfrML9xkjSgwauup5PxfpJAUyQdFvUkU/EHEQwlJ0dc3/Nu7Q+oiFiyxQCqg5L0
         9+d/WinTTlqBz/eQQ4x8vPKHalMgmqW5U6E2vhLaldlbyf88rGqnHjyIjEKvHSl9jfkg
         R1MbpsXGDlQH3eynh6MnBtvIYNFCDkuqm2aBRUqk1DZ9NyY96Z8sgvBD4gerWYAe8S5I
         IVSuJhY0jMMRQYJ2Yre65/8du32bI9yfK+PUoTmCpSoAMZ+tpV0FG14IcDqTUHvxAccl
         C+QVs1FY3A1ais+xxU8A1ajhblP3Bewt2d9Stfpy/7KVcxfRMuyPJUBWFtv+OfUKDQM4
         FVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527446; x=1795132246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mczvvyy/drg/WCTWwSqRdjrsqzKouaYUkQ4KLSPDcJ8=;
        b=Ws9A2fxV/ID376br0pFTkU51pZhpuGAT1SdDKadcsM25lMys43GNXKrwC1FB+RPolU
         qyYH4IrorPRxtpWvaR5GM8DdyoSQrD+epdxhehgG1t1d5Gj7pF4qGXZc4BrhxeMUzcOJ
         1D0mBUjeMxqBxYYicUP69qfVCWjeoi63Br99AsWM8G8/qtrkQFV4oWCDqxLhF77y6XIO
         COqaZ9XpfPHZQbEBxiPfnOuLw6acZGgzoTrMSU5yp/cmR7uniuMBqtQ1SgppXteA/ACW
         ZNp7ptZHAsy4EtqM/aRzxEeropalp9TmGx1gCoK9BDcVjVIxghk4gviWC5Ahqv2DApEz
         Oe8w==
X-Forwarded-Encrypted: i=1; AL+hErFUVvhvr8ETWP+p3hV3uMJVHY2NSwwZ8SEMZTZSSj0NP48AioZ9VPfb+m276XAYiAHZnjp8wnYInL9TMFtR9X+M@vger.kernel.org
X-Gm-Message-State: APuU4Z9TCurx6FwZZ1qqmkpISmHYq/YqXV9NO8Ju+YwyYBHCe4XRnS95
	4lnUcsFXtqqw6UkhkdN2HlHNe4veCYKW+B2urvQKRowLFv38fYdxo6tS
X-Gm-Gg: AYBFou1H9/ipWJ6IVhSIE1moIFk7woukb1Rfi1u5IrOw/TUexNldylMEm1jQWZp19bX
	S9ajsEn4Zsl9yIK6lgdck2gG0ZuTTo5NLNN8nP5J/6MMNH+wkExf/8pSQuDtgQn5aHv35nHalHF
	kdXFNJ61XhzewUDVdutuQZc47NSQRYbAzsBThuCOTUB1TGRymGYTZQYFSlb6i5pVD+3x3Cz93hX
	NBmKl6ISEQUQx5rTqmicMOxrZOq4byOeF/EyAfJce2KJsb3KHS3scTGeOg/H0S5fyGvpnSF0rUd
	RvpBntP8Db9hzeBfprj1H5NpHELhM2lKca2xA9OCYqyamg3EmAtPzXRDdvmQBQSrUWclbIkwFoj
	XbVsGgiFvD54lpdb3i9ik2Zgme5RjHoFqq22rYBtd4d/fA/LqaM2OMj1ROQu9U/DELumO9e4cIt
	Fb5eyP4Ylc+tKx1unGj7GJCKkDX9uzGYMaJlF7gE82YQEDiyCChaWGrqVe+gRMYl/t9BkiO36fi
	5k4yfrIy3V1gI+zgJQo0p9xQo5vgwzAULzKH+R9JpJK8/DscyZJAblOPbR9sLysx3rdJI9RAJoH
	yJ/yPteI1WAVTYyk
X-Received: by 2002:a05:7300:cca2:b0:36e:371:8255 with SMTP id 5a478bee46e88-379603825bemr628008eec.0.1794527445599;
        Thu, 12 Nov 2026 15:50:45 -0800 (PST)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm3842976eec.8.2026.11.12.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:50:45 -0800 (PST)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH 1/2] perf/x86/amd/power: Fix missing CPU hotplug setup check and cleanup
Date: Fri, 13 Nov 2026 05:20:02 +0530
Message-ID: <20261112235003.18608-2-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112235003.18608-1-ayush37735@gmail.com>
References: <20261112235003.18608-1-ayush37735@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of cpuhp_setup_state() and remove the hotplug
state if perf_pmu_register() fails.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 arch/x86/events/amd/power.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 66197214b010..2627d5269b52 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -282,13 +282,16 @@ static int __init amd_power_pmu_init(void)
 	}
 
 
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
-			  "perf/x86/amd/power:online",
-			  power_cpu_init, power_cpu_exit);
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
+				"perf/x86/amd/power:online",
+				power_cpu_init, power_cpu_exit);
+	if (ret)
+		return ret;
 
 	ret = perf_pmu_register(&pmu_class, "power", -1);
 	if (WARN_ON(ret)) {
 		pr_warn("AMD Power PMU registration failed\n");
+		cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_POWER_ONLINE);
 		return ret;
 	}
 
-- 
2.53.0

