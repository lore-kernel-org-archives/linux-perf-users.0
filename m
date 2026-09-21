Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CC33D505
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964861; cv=pass; b=aNjF5MlG4PkoKgmtHhYpjoa6TX5SadyElHXGkVZ3B++WyKg9Ja1vvAfwTFS0XOj64Sjm0xSDnVdk2IkWhDqLsvXgckwgVnBxWe0ud0Q4Kl7FVfAlVaSFEro58a3z91/l5XWdB2baPcAkq6zK+SGS0KuOsbVhs75GNxnVxhbwIbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964861; c=relaxed/simple;
	bh=OXHlmbHqYZPoffpzb4G+f1JwyrrSRzIC2VXrKgbZDkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oqzv22YCrLI8+SZvE4ghgc34S5CafWwfxATxKCLVHhV4yvdm1Q6bm50lOCWMnOzrwcxV7AtMSfy+TZ3g+1bC6ZkLLlnxeXE2AhyLnXgQNtFOmj/Xh0LqtrNK66eXwMAOMeGQxF1CJ4TB2WG/wLQsQazlm5xZfimD4zI4y5+Yz+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=VRWMS9G1; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="VRWMS9G1"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201f9so2028297d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 21:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789964859; cv=none;
        d=google.com; s=arc-20260327;
        b=miZ5y7y8/OyZ1DpYUyw97kVSO15mfIdZYnHkY4KG88LXuDQVIuQBpmGQEfIbBCeOKK
         iqy4pA+kDJP/9TRFNh9Il45nrAkNc2VDslMs3QGGmcfKRfiFX70sv6e7/eP+F6siRn/q
         p4/mjkjulh3F/q1c79u3WLwOcJyN3MUBfl38bADmWMH/Z6uDYMyNf8UWu36QS3/PthoR
         twNQT82i95/EV4XWd7NhD2V4r44Bij+sNGRfwOa7JLozx09zwUnBV0vaDcFNTdt6qG+k
         VDyVeZHMe4ilMigFkHyIVkEM/XzriLxC5ohiXcfisWPRTmTCEEooOHfd4ny96LdEyHF7
         39OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHXcPbrTNAxtI04gX/24blX4z6iN9+N0kM3fkVzoCUc=;
        fh=aXAifW81mKEAgFxqCQZtT3F+8RwTkdri1EgXiBu/3kM=;
        b=DaCQhCc5lukjnzxzRqdZSoyqc87rUG35j2R9D6Iag/4q/fvIwftYdwLYvV/ITGaO5m
         sYtcRhtFUOrkEmgHdjmdEBCMzD1I5M/ysemsQ6j/wCy5Q/8H+/RHZtz+9/OP0LVolIxi
         Aby9bGLYlx/qJLfO7orHyTdQhtNhkC1gcpprW97lllcTJ8LSAP9ZVd5sOX38h+cD/Mvs
         xgL9CL96GV/isun/QkPWLBiAJRV5CvEnPEu/ww2jv8yyNEI15IVJKatUc1Bsz+Cj/TLa
         0GoL+VYFRMxXvXrEbXWQ+A+SJjAsQPBJ5BBTLTj9fYt3ITo4v/c+KYNmLnn1AMzSlrc5
         +zgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789964859; x=1790569659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHXcPbrTNAxtI04gX/24blX4z6iN9+N0kM3fkVzoCUc=;
        b=VRWMS9G1Cq1IpDDpM99kgry6sBiqFNEKa2J8Nen3ORd4d+LcJmugpiEvns6O9Sg0yr
         JyGqbov2q8/Ld4KSbFQla5BCLvbNYr/HCbBL4Tn0tbXap20YmEqxn2UlUCenS5P/XUCR
         uAW2VVwT8Rk1hM3u/WWaQpl+uMp6XeC79basU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964859; x=1790569659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHXcPbrTNAxtI04gX/24blX4z6iN9+N0kM3fkVzoCUc=;
        b=ekG9CAoVHB6KvMC61FC2smbEJ2IzDKspph0JZFJ4+u5FvNqPg1oHFe1Krzp7fiH9dq
         NZ9rA+bam0vEU9yh0R7Pixf6+20Yb2622FagveCPFMB3dNhxrys9lO8OVfEpFzTuZ8P9
         IyP1zMWJwbGPgO3YrwaOJRHqO1LBMoEGg9R3yPQOYcR1fknSnUwahE/ID/qslO/kjKnK
         CPg/ALAyGr74BO2za3u4gkmARjMRAy0m/Ti1mm6wcXPDdBtq0XV3dVuI5A1wJojNowla
         znUzPpnc+O+nEoVqHrNr9VTbf4OyT2kC2aooQwduQeJb8U+JJV979ms6AYufq5tsjfBL
         q0ww==
X-Forwarded-Encrypted: i=1; AKwUvBwdLCrh+v4h8fwGKUGPUvEVD0+X+BSiGXwiLusXeZHgMLmLQMrqun3bEvwLxTnLi7u2NbCanBGcGOZZZJ8FYGyh@vger.kernel.org
X-Gm-Message-State: AFuF++mdgzwtEtToPX1hpSB7U1WG+UAFDzlMfyz2kaDuJFCgcihchtez
	BoUPNbH7xAmy1c6BJkydVWmiGv3b+qiZ5+cJR/PRUVRiunCoDxTL/2uH4ICtgL7j4nnD5dW6U1g
	lLdiGawiihXIoA4OTW8axke6Xh1Ybmk4Ccmtnr9aWGg==
X-Gm-Gg: AYBFou19joNFq9OcO0inXjJJQG6b5bUIYnWd2Sn72Ml80+sEECHArsrOXT/LdB/gcID
	TkkRWBtMtgIdojkolfIPgbMI2nRPJBp3TtM9ovdW7mjWV8/LegOiTUbvjxUBwBaIiPuNf9MNBQ/
	uMuTurzmBDBv2EZad0Vj0kdfVlt3wbt7F8m/Lf6o2zQT/VPBMad02+QjDBNNa32oNsPe29O7Bia
	KwYzmGi9bS9MUctZkVUdPE5nJPwVDFqcPuPiTyHBaFY2e/YSfAYv/+bwhwfdY7p/U9AGrLnBpVR
	f9KIi5VgMLfnTmz7HnmzWQFUEcDEx5BcsCWXJtAGDg26xB0N1lXq4jMshQ3Z9aiALFboIDl9bps
	nI+q/+p1sGTA=
X-Received: by 2002:a05:690e:11c9:b0:66f:b1e4:f158 with SMTP id
 956f58d0204a3-6717fdab5b1mr2698964d50.46.1789964858081; Sun, 20 Sep 2026
 21:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-2-495b8f00ad7c@uber.com> <arB0RCpi9szb5d_R@z2>
In-Reply-To: <arB0RCpi9szb5d_R@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sun, 20 Sep 2026 21:27:22 -0700
X-Gm-Features: AcwNN1XQbDYRv7d1MBZTRlnAPAQksPbSbaIYVIK2RGcLdF2_Normr9MWW17F3cE
Message-ID: <CA+w=M=Te46a3918scFJrZ=KB5O5idGRFZL6LXH24srqPM2xC+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > @@ -90,7 +90,7 @@ struct symbol {
> >       u64             start;
> >       u64             end;
> >       /** Length of the string name. */
> > -     u16             namelen;
> > +     u32             namelen;
>
> Why is this needed?  Do you have symbols with a really long name?
> Anyway, it should be a separate change then.
>

I will drop this change in the v3.  This is a theoretical edge case
and I don=E2=80=99t have a real workload
that hits it.
