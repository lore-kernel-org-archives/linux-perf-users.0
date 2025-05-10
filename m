Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F741D86F7;
	Sat, 10 May 2025 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746856729; cv=none; b=FxAyZamzmsRVwJy9EadGdwRgFq7Y+mvLBlzPrSE8PUMDGjqdr2031NvWMFtc9ze4vpQnqEH4NhBaNly1Rpw0wvOlbm5y3/kAINqjiRHymDHC/7KeFMJ4+TQRS4Ww0FwsBDCKFKUBU5VlvyaIUUxDOAXO/U7cbz+NKjym7wDrRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746856729; c=relaxed/simple;
	bh=Ak/3kDW2H5mJRaqud3LnLTy7IPbuS4V++tfpvlmoDKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcuf29Vp0Lcn9Sp8Qb9y0WTIn1TyGQvbrtUiS+pN97pWKVCn7v7UOdfwlTxZWceBYjBttrHXIA8jLXe16kTDt1G+dfC6eT/Pf/j7k46U0kThEpoeWUpZv0gxV3RmvV2flv+Z+nIPtic0o+B1Q1OK2SV558nfn7krRkzqk8kJeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIJGPDiy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIJGPDiy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b061a06f127so1822514a12.2;
        Fri, 09 May 2025 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746856727; x=1747461527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvSrH0m4IUpU+lJMf9GPrH6cvsJ1xHIQMLaVbqpMvdE=;
        b=GIJGPDiypqnFcgZj4zCk2i/SO5cShyAkZDUp/4lP/YcklO7OgEZIPSHHnmoSPdUz7n
         kB3CXq65N/3JLhZJShuKs3mnz17d4aGl53oVMViPjlrzFmdnsPdIK4ICawazxVRx0WV6
         To+2ZlKyOunPZY/S8FrV9MU70P07rIlaJtAmSc+H1WCQ9y1caO2iKNNqYzVPZ7YT+Gz+
         URqQehmmIwSSae2b5v3gVKgNiV+rB/OzaXMi4BjOaskfJynS0pdwMJ7FzwRp70o1+7+b
         fGZ0rtW/+iEJ3iXBaLkurb7nVOduFtE0r7GNHTxirkjOf+8lVbgvArXG4x0B6iK6c1+e
         lexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746856727; x=1747461527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvSrH0m4IUpU+lJMf9GPrH6cvsJ1xHIQMLaVbqpMvdE=;
        b=xLNzFzu5gz4Z1OyHNVSt+6KfMUDtFhHGfQ0HTteyibq1Oi9ggXIOUob26ooaYO1b7P
         48iCw0SayZ+PWYi2m4OysttVf7G6QT9k0u3kNlVigyO2bs+55HxnDyynnq2+VR8mEn7Y
         7Q3cWlY6S36bt+VvyW6/20//CVq4g0H/nbQ+zLRFImW0wAzAMqmGhxeUJYHvetz6vKNl
         xzLZkpu/ESe2zIY4TnMS22TcwJNZGBroQnCqZI172n9h4gt66RyZDiviAlkZOBwpdGsg
         gj/qch/zVPS7c8niqnKtfz+eVewedym5tXCwy3J3N1XR91NcibYE+HG9duaGMi6x6eH9
         WQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4HvHTQpxbTYvpilL1reto8GcdenKh7jFJXzwGX0owTDbRdzi/DDPuUhLk5T3kn8u+k0tcD7nuJa2FJz+BPN23jA==@vger.kernel.org, AJvYcCW8RA1m8Gnxs6sxr6qt3qPoq0PAiHfVN1NXnEGDOFWzxPUwx4AEeE1oI2cU/b0sc67bo8ezXcL7XFIL@vger.kernel.org, AJvYcCX01a1hyi/GkYnm1Uh3Pr18DM20UvVa2AcF0/9SdTkIgJR6V28hRsNN0Hk3Nc/lMrcRMaKbQlWK/dp8tlAw@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqq6Uwp4xB44RL6Z1rotPi/cGkvpZU1017i63f+vwNuJLInX0
	ifjeT42MpmGuvM9IFhWdqKBkguopJasIsM9wtGKYePwZNimBCEwp
X-Gm-Gg: ASbGncvZx3tfFu2Yp1fIsS8EwtAcYbnoZlWwNp7yQou/eLz+yIGdLFV1CzlSnOosRX4
	fQgQlYS3bsencCNxeTK7SnqV2BadrrtdCxKEJPIFCMMh4sa2T433VtMnzB04mrQxC0UxnC/5tIz
	9snW6T5J72HHeTuOKqQ04kx1YZpbrI9dfzsA0kj0sscO+BWVXf1P2FmPZgjtnVPDk78XgI/8I3h
	s1BQDivmvQOw0uUPk5RcTqMNI/kurQ9x3a2S3ENYUbBioTE0BGVhPBhU3FjXHkpIjUWhhA3zXdk
	5kiNzvuoZDIs51UFCHg4WPXbZDhSFLSXhERO7U43v9E8sv8fT7XiFl8s8UG+HNc5N8k4uw==
X-Google-Smtp-Source: AGHT+IHszysuOKe+BXliXC54u04RRE82xYLl5n3Hlqtc4Nnx4bwzHJoObH1iIIdfyb0NhtdrtlIVMg==
X-Received: by 2002:a17:902:f612:b0:223:54aa:6d15 with SMTP id d9443c01a7336-22fc8b3b39fmr105809735ad.12.1746856726879;
        Fri, 09 May 2025 22:58:46 -0700 (PDT)
Received: from [192.168.0.121] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc77413besm26910865ad.84.2025.05.09.22.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 22:58:46 -0700 (PDT)
Message-ID: <fa4f46ef-0f86-41f8-afc2-afc8dd2704a1@gmail.com>
Date: Sat, 10 May 2025 13:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
To: kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>
Cc: oe-kbuild-all@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 devicetree@vger.kernel.org, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250429-apple-cpmu-v6-3-ed21815f0c3f@gmail.com>
 <202505071747.2b2WEajY-lkp@intel.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <202505071747.2b2WEajY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


#syz test

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 365b4ecaedb1..81443e5158b2 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -1082,7 +1082,7 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 
 static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
                                struct perf_event *event,
-                               const u16 event_affinities[M1_PMU_CFG_EVENT])
+                               const u16 event_affinities[])
 {
        unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
        unsigned long affinity = event_affinities[evtype];

