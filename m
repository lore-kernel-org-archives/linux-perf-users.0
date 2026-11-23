Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440934;
	b=sO8Al1aC7Hhz2TDzKb+6Dr3UOa0e/UB0TxzH5g2bnS173y2v6cinE/f6ncq5kaIIaOZ8
	 LlLNJjN+vnGV1FHOpg05Jbm9MjvyXCEVzaKZiYn/tJ94SK/Hn7wgH47FJv/sIyLBtCUdE
	 AYz01YhsoNlcURvSpeQ/8BaxmB82zZLsMDi0pkR9iUbSFrAWwluxWonQWXaRnEL/efevT
	 kXsYsTOmoWaBP8PJ5RUWrw0qM47T1OznDzkkWI+2n8cNdv1lykI6b6V785p5hGKK0GAfq
	 h1M5YRybVkB/hOXaQ97Uq38PvguKRjCqU7c8I7LtV8XsNahcIpgC6XGK434hDMYf1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=scx32ipdmzZF2WgK72vmGUFyDo9O6eDPU6M168osIuc=;
	b=aHftzgQiqdj52i6hmw1jbpsVPrnEzBn3/Iq/G+F7Jda7g0nuPhi5EcM/ajEQkiN9gRue
	 p6+PKBCtDHFI3SxTfJAmZ3htk1p8f5TPuyDMWkLpOqvOx0k63ZHxAlkq1gI03yk6y2aDI
	 Fwk3x5jag9h1mai8R0Pq90xta5IrK6bAhp6OQiaz2N9Ff+axFCkJjULvw8AR+j/IYeNGy
	 VL5sKIxxz2+sAIllqFqBkC1fqqzDTSMnx77LkvVVbkcWeB3u3MhgtlJLT6iSEFgEHr2Yh
	 j4TlUDN6mpv1QuOVu98OQ/MSxk+rp4qYudtHPrVbfTAEg7KikWk3EAasnU/xuVvplmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/ILaTU/";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B5606A33E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 13:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 415B5606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/ILaTU/
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so28285015e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440933; x=1796045733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=scx32ipdmzZF2WgK72vmGUFyDo9O6eDPU6M168osIuc=;
        b=v/ILaTU/7bWg5GApb65WLg4awDJCuN4p4XNf0kXaMPqk/HUIGDI+Xbq06i9Utpmmib
         OQqr1eVnIILeeQbJEVc6ncw8bSGgj3jeChoH7Kk9A10TQi44Ww+KonrQbb+HgffZfa5x
         zFhE3RBlJLcMCY1gvOlSZpysY7c4VWE1XkPTGubFxj+AIgaXW7naxrT2vgHXIDW6ki9l
         hIOob0L9YMtximd5TaiqkDZTYXkuCXHIT/d3HUok6+HqvuFW6kipibWhKWZ+yfM/8J8J
         t5Jm4wul520REt2NLt/eRPryrwbjLY/Me7G/0vHxU5v2Lo8Si9vl/jxkpMFKhXHiltgP
         c1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440933; x=1796045733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=scx32ipdmzZF2WgK72vmGUFyDo9O6eDPU6M168osIuc=;
        b=YPZOkCJpK4Q1P7g5ADyHb7sekn+AXPPMQVTrK4D86fBd+KYnI+c5DJqhcNhWXU+A8Y
         9mgb9y8I23hZ5+Z8yYzWBbH3AdJh9BgAcqgRA+E7CsdHecrxSv3ZlFzKMurp1msjsiho
         BBVhiy4fbiIoftqWyBaosfEczWy3mrL/wuV4oQw+voxVdoTlaSj3Cbn79gnYtOSw1GY/
         5dwgSIj4iKCdvqTqtmuQW/ND5Tg2TrR6aekcknyXdu/Oprh4z3eyId8ZYqDiRXes8F1q
         BlEKg7lUyH2X8fdvxWTsauboFm2DT6Ian4YuwkFxYPK+JnLVB9k5b+J9gr2eE3X8zgt+
         vK9w==
X-Forwarded-Encrypted: i=1; AL+hErHwIdsbxfwiTEyx+ID38yWax5xaPMqSgGe6nu6VGy2MHWVa5swpNz8qaaSPY8jodquaNb/2AGR5C00Qq+m1nfO0@vger.kernel.org
X-Gm-Message-State: APuU4Z/ykSL3LnwGPxqjiRGN0i0SDxOMGbknQJdujl0avXmYgB4rtfRZ
	cu6ztpFVXV3V2QsLEEPelD/i+XqXvZJJaRZaKw9MnONDTUZefXgKJgLs
X-Gm-Gg: AZFdTZfU2jKgEIWo7rREfZ1kyY6qNWC4jve1kaXtx7YhITTqifbHmLpD8Q0plDwCVj4
	01byUjfZptZTZm46WJ0iGPCj82kBOGDsjNpgh+hZj1UMhDjiNIcb4QaTaBZcXVRqvuuoPpPMCUL
	KSdTYPzsTXsoksaq2OR3NJUD6Mo4PoRO628/qFBRAWVtOsS9eIt6CUFWcGTZJZuurKYn7OriRaB
	8QiZnsHlt7hymlPE7PLxMiqQHu6LwRxYcDHPnfGzzARn0pCTPG4Mm4Ec/1m0NHdibF6VF1IO5Im
	FTHweTvoua/Z9Xkn7XNBS63iViJaKno6WcHhD+cGvDTuOGxHINtSwA9BTWSWAAqSy8NgSdta30B
	eTuCY2BxnB9vTPM8Mz3uDUYkG/QB4gcVN+61ftPSMF02QOL7IBLI39hBKTvUlE+zya8RAXui1Da
	pOdqxY384/Z6yu82rQ7/I4oWJIUdvvgsJtqPBAZQ3rP+1BWWbm2gLa2it2RgE9nUD5PhGduZu2F
	M7vtlEShpUBlYIK0pXCf9A4qNcs6zQaAwR/B+whHGyOnMsAVh32HYI2RGjkti8jq58BFd21ksHK
	GeUC0arTmARILhlFW+0STOn44iEMwIGhgI0IRhl1VojoVESxwyNDtWc=
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id 5b1f17b1804b1-4bb887e265fmr224576995e9.3.1795440932435;
        Mon, 23 Nov 2026 05:35:32 -0800 (PST)
Received: from CachyOS ([176.88.126.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm504183485e9.11.2026.11.23.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:35:32 -0800 (PST)
From: =?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <asafbertizlioglu@gmail.com>
To: jgross@suse.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux@roeck-us.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tony.luck@intel.com,
	ashok.raj.linux@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH] msr: replace rdmsr()/wrmsr() in comments
Date: Mon, 23 Nov 2026 16:33:38 +0300
Message-ID: <20261123133338.39023-1-asafbertizlioglu@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123080822.3426355-1-jgross@suse.com>
References: <20261123080822.3426355-1-jgross@suse.com>
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

On Mon, Nov 23, 2026 at 09:08:22AM +0100, Juergen Gross wrote:
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -67,7 +67,7 @@ enum coretemp_attr_index {
>   * @cpu_core_id: The CPU Core from which temperature values should be read
> - *		This value is passed as "id" field to rdmsr/wrmsr functions.
> + *		This value is passed as "id" field to rdmsrq/wrmsrq functions.

This sentence has been inaccurate since it was added in v3.0:
cpu_core_id is never passed to an MSR accessor. coretemp reads the
MSRs with rdmsrq_on_cpu()/rdmsrq_safe_on_cpu() on the logical CPU
(tdata->cpu), and cpu_core_id is only used for the "Core N" label,
the sysfs attribute index and sibling matching. The current driver
also does not write any MSR.

I think the sentence should be dropped rather than renamed. If you
prefer to keep this patch mechanical, I can send a separate coretemp
patch for it.

Thanks,
Asaf
