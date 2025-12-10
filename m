Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F030BBA9
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362296; cv=none; b=NztZU1lzqqEm3547aOrFJN8v98/Ba0LLy/5y/AJ7NoyqKjSbxh2swD55I6ogUMfstQvNHzJivnMRoE4QvmC5v47OPEY7SvOBHAMPUqAMoCqJSUk9jr5WbBPAUVwyE19PNplPc6i5djw26b+0bUHgBHVE4XF/ddXk/4dIEXDCDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362296; c=relaxed/simple;
	bh=f9u4C7NEoVlclTJcpNp8oU7h5Z1t5JpB4oom27m0d54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF4V3isaMFhTlXuNY9Rp2QwEXCYSzBiJatG42iwkMhfUeAyrNje4+AMhp7ZdEZizoX5O13wBB+M5KQvBHz+Fwk4Shp6sxdVhwQHXkbcg3c6gaD8drWGxbtqS33hfjACcO1Mej9BtJZ1J/bcPPVp87BBI7IrjWtiK3b4DOxauIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN2MHAue; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN2MHAue"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-37b9728a353so91806931fa.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765362293; x=1765967093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9u4C7NEoVlclTJcpNp8oU7h5Z1t5JpB4oom27m0d54=;
        b=WN2MHAue4ZaMztOtilw51Vt4XG1JTii/bufOQ786zUVY7lVBbVJYdvPJKVYgimHgha
         Jhl8NQPVlr60MhzuhmCFsZqdsL+T8S8JA+/aMNAeLNL7uzLCPcyHmL9lkDaNIpqbPA22
         n6oX4/5wfr0DsrVp6rLa+w/vpVBxSbB4/bXSv31nj6ukbbDQoYGm1RdN1r/nIu89igoi
         s+0M8CkQIzhj5HQ061cFGAKiGjxTWio+48xVZ6+Ba2j2XKPIMm5yA3WTYTA/tH3W+1SV
         iPyYWxogt04IHO2vlUgPh2SXLGICHX5ytNcL+deQwu3abHF4AKX1FLv68IVTAQQcXxaq
         f0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765362293; x=1765967093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9u4C7NEoVlclTJcpNp8oU7h5Z1t5JpB4oom27m0d54=;
        b=vaDc4qutORHRmVbDCQhnb7x+7h2MS3ZsJEdp5wmY5M8ab7nGSfQzCKt3h30OxhOsu6
         Lh42/9WLVQZz+J9GXo9Y5Z8IInjZZfrSU/EvjaVB2hx7llK7oCimHpytf8UScY1Wf7S9
         P5TmbHGrdM0chro+ycAbZV2G1uaVIpsq2pMWmzJQEuFIjsIYCM5ij6W+3gSMNm5zzZZ2
         VNT2sRkOshQm8eZ4RkblcFdBS3WRqZW0loWiS2aAROPb1goezGAaDpvDV3CHwa9ehb+9
         HTHxrn5JXyyj2w4LevT1kZtmAH9BDeqdtOCTDMWv9kb2NNgW9FjIb6INJqwHhRUGH0dK
         uP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXIyUGsM5p4bo94aoaQXDWbeSAUgXCr8yD811977lPCROtu1fikjgqs3ZOipP6EKa/OAdlFRtRuZSiWV9MmzK1b@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4GPcsYZDrX4nluZmmKT5pUYODIoyx2s+ZhzULxwrKwRXyae5
	51lPz6gPxFZPqnHbFRnTCIlFYY/3EHd7HZZNNl9FaOG/A/k6c0wIQ7XIED0WJqYMrqAWDcM7F7e
	Rw41Y4qMu5OAThCc3dTxEV6f84LG0A4Y=
X-Gm-Gg: AY/fxX7+8MQF0ig1Wx332t6+7kO79kALnnsm59Bdztm4X4XmGlQiYSBXtSAwe8bivs6
	19dttyOvW7LiKDmrC9RfcLinQw8qoY52/BwY1bBhjlZKLla6I2BYXjAa3HWuW9xWqtDcNImhBoN
	qwbBHwM1a4xwYwYXory9pOI0i6MMn5OMecAhfYaIM3Yru3jwjDWXAS3w1jBWJ09uOmbfTLlwin8
	Sj+4JfNHNWnGWegtJWTLwlEi6hZ98sK6wKrzKIuAG8NbB4cW7KnCon8oPkRyoyhwah5/vtp
X-Google-Smtp-Source: AGHT+IHt0WLcXNnHGZxmszOzXTu1AVLg68BV02qQIUefBmF9FYGy7+6y5jRV0wMK7M15U3dP7NEa5Qc3u+xma1LwDUQ=
X-Received: by 2002:a05:6512:b9a:b0:598:eb48:cdd7 with SMTP id
 2adb3069b0e04-598ee4a686bmr836854e87.32.1765362292376; Wed, 10 Dec 2025
 02:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com> <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <CADHxFxRdqBFq1c7wNViP0TRdopCCw+9y+hmaU5wNZLodKBq3Cg@mail.gmail.com> <CADHxFxT7dgpAZSM0AwcAs0X-w6H+iLRN6y4cLE=ERA39gQqKsQ@mail.gmail.com>
In-Reply-To: <CADHxFxT7dgpAZSM0AwcAs0X-w6H+iLRN6y4cLE=ERA39gQqKsQ@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 10 Dec 2025 18:24:40 +0800
X-Gm-Features: AQt7F2r0I-hPCKhl1Z4cP50Eif4Cbj-J1c0vAT1TyEyCQefh7tszu_NThLdSAIk
Message-ID: <CADHxFxTDu31aDacgyCsxfinPh8KvkgD7HPgU5TCviUKH_j1-MQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND AGAIN

On Mon, Dec 8, 2025 at 5:05=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> RESEND for your attention.
