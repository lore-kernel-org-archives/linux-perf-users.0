Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA744CF52
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541920; cv=pass; b=DNMQT18kk2lm50zX5sY+1ogZwxbULgIBLEQH9UAkgZj//QxMpo2XB3RnZxLOlpcpZoaylBa/vEr4s/oxY/aHnlacjPTI7lV1hcTagwliTRgqJy0n17g1xKz9hdlGZDIuQQXr7X5W27HEBeodRQuhSfJeeyMncvL0p8hELDQBkNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541920; c=relaxed/simple;
	bh=huenUMl5uc0M2LnoWQjZXPUhYAeUlpsSxjwMFpT+H8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZeaySaLEtSvmW8ane+LUjUfRsgJ3waLLBhQWJHEcK3AoBpCWscPp7UMK/NefUWL320du19p+V5mHRFYXEESpqrp+eMdzQyu2Xu6LfTMYdf4pZXO95GodN950cLJN2+DGUQTfz1hoENs7tBDLfJ91BjH0o1bz6DXJAOERZxr1jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHg3QkIi; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHg3QkIi"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so236731cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 06:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786541918; cv=none;
        d=google.com; s=arc-20260327;
        b=lRGdlg71WG63fKGDXt8l5OVY9kZB96UTYNAz/uNi2mDwsM+3K5+SJwBXbIvOGzcWUf
         BUWYwPJOlmvgKNBuGezD/PTNnZLxErd3kOF6yqwxMLejSiCEShkV+uE2hGbf55qKrm96
         1Kd+JNk4L14TWRMA3RmDUUfVeDDvI2ec486+SQsvyhrKyw5y56HWffmZLpidgRSJMoNo
         iW7b+KBbzNYCr9EtVYZciTQkZBMAsZsPKVKT2U8m3S9mFpFIjzVp4IqVIjN21psbUJ2B
         /50a42SUUKsm2KYC2vDpFFPQVRz50pNizGKoQMl1Km/v4C9cTMq3b0UWKXcjky35NeiE
         gl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=huenUMl5uc0M2LnoWQjZXPUhYAeUlpsSxjwMFpT+H8c=;
        fh=wXi+XmK/w2n/Sg+31EmPpXSp/Y8afBzk8dK2vSBSjro=;
        b=l521UEjkLAGLstJQ3Y3Ou5Y/5Qyxf9a0Aam6kjQ/I6GB7byXtgw78omWRDV8bd3iXZ
         qoNIX8Afysy100mXlvZVQP+yEGkOivAgkSRrtGd5YCPrm/rS2HP8WMOeI7Ye2Ksb9Iqc
         D9ByEiHVaqOPUnobleM04lL8HBm+2CM7JVVef7ZsMZHIX4WEJBHRt1z1iYvc+eHDrGl+
         Lv2cl9U1uzlBKyJ1RR0yC0z06r4KuvlJyvxyc9Mn1SyieSaplR4DoWad4GTKBFVZ6t2h
         5XJkyB4ZQEpO9PzHirlNHet8q9Yfb2gqYpjjgPKuBPgCIp5kLGii2S1Wdta1pLNX9V5b
         bC/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786541918; x=1787146718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=huenUMl5uc0M2LnoWQjZXPUhYAeUlpsSxjwMFpT+H8c=;
        b=cHg3QkIiqc+EawtGUbWsARYJ5+pL8KmpVsJ6SEiOQWFqe+nJj9yIDzC06GiER1NiR0
         tB3nDlJSQzp5pmXqWOOGNVLdRXshNHg1S+DiDjW1OVEsiZi1hKeLSf8A4LUCp8bNVaNj
         p8rOdEB1PogrO6BLjX8D4t2hw8xE2xWBavnGvdiNhDYX1WIu2wEVcOWaudehHHo13eZ4
         r4kFdAU0VP1cIZhaI4FZpB01PxozAGOZwOmSPLFz3tRNuUlPFd9adHnW1IaQ0o4l93Mo
         dSoEU37NtPEJzJGF2L8LgtUPHq9896dsjyh6aqnO0aeIiD3L1q+BOWEhFrVCINGBsPtQ
         WEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541918; x=1787146718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huenUMl5uc0M2LnoWQjZXPUhYAeUlpsSxjwMFpT+H8c=;
        b=cSa5Q5Tdv83aGY9VaFHDqI95ZEAxJyRbNxLGe1waRWgvuhR7BK4K3gGf2GHVm7YXDq
         zFUalVyeBhRtset78U5hx33yRppNGDqST1mVLdAi0baVowdlS7Hal7uKzACnZT8mQZzS
         PumgB6tXPJ2L77vgj26dKAEaw0SNL00p9U4opjNQnC0bwKbw94axw7oI50C5mX6TvTs/
         vrQbI3GI/8BiDaOZ3GfQ2THeOcYBpSKEFsk/39WdDx8yd3ZlE89WbpePRNMoVn+2zT7r
         mbcS6j8S2EFETLh5pJ1khCNfzYdXuRcbBJcnylpq8BlqLrwXp9xKnicDVOItIWWAoeq2
         hsXw==
X-Gm-Message-State: AOJu0YziwxKNAe2y0Um3XjSBEwYlgTFZ+5zNas9eS1kVDJNZKWgaRstG
	wjA8mWU+eAZ5S53UeWc735mMRruTe8vbnkjIA00l/LzFkQiV5HnvSkEkq8vxwYvrmzBwW5Q72+Z
	Hl/a7aC8Y1UqJZv3wdA8Tx7g+bIEHWzTgdLVTDmk5ej7GRcOGWHVBNtFA
X-Gm-Gg: AR+sD12Vth4y+KLnAaL3tZzIwZM8tA9q80XYyFFglU+GqjsMT1LQOodO53Cw6CJDjhc
	nGyuPJg/Jhc6bsxi6cN6CPutl9Lnc1YwsOxZGCcpHVmXYdtm4UKvcEeEMCFEGwSTZbvRQ8liWpx
	4fs28vst9op4WooYZH6jTGiJV/nKipSafiS9T9BhfvLnV/HMIuALEP3APYRXT6y/TodEeWw6L9I
	W/LHtm6HMV4XPuUDVTZmok07yMAgKry5EDGgM8b3T/9l/Mr7DXnTZT4YsFPstDiOQIELITOLyE1
	v4J2mK0y+z4VGJX5cXZzMh0eY1roF2jygJC3KCxFeE4t0w==
X-Received: by 2002:a05:622a:1e17:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52d61fa3c57mr18485041cf.12.1786541917310; Wed, 12 Aug 2026
 06:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
In-Reply-To: <anwuYYxLFbtDmmHx@willie-the-truck>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Aug 2026 06:38:24 -0700
X-Gm-Features: AUfX_mzhVvdWEb4aciWXtp2N8iHPEM1EXkzAp_fI5yNdeyk-XCZ5nCpn7hjB-nM
Message-ID: <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Will Deacon <will@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:27=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > This patch series adds an uncore Performance Monitoring Unit (PMU) driv=
er
> > for Broadcom AXI system and VideoCore VPU performance monitors found on
> > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).
>
> Why are you sending four versions of this patch series, at -rc7, each in
> reply to the previous one? Nobody is going to review that.

See the cover letter for changes. They address the sashiko reviews,
you may not see these reviews as they are only sent to me and
linux-perf-users, which is somewhat customary in the sashiko setup.

I don't see any relevance in rc7, I'm just mailing out a new driver
now that I have the opportunity to look at it. Whether and when it
gets pulled upstream is up to a maintainer. Another useful series to
pull would be (imo):
https://lore.kernel.org/linux-perf-users/20260101-apple-cpmu-v10-0-48812c52=
9ffc@gmail.com/

The changes are sent in reply to each other because the entire series
is visible in one mailbox (b4 mbox), which I find easier to work with
and provides me better context. Others use semcode to do something
similar, but I've not explored that.

Let me know if I should drop you from the cc, I placed you there as
Mark and you were the only suggested reviewers from
scripts/get_maintainer.pl but I don't want to spam uninterested
people.

Thanks,
Ian
