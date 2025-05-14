Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7831AAE13;
	Wed, 14 May 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253755; cv=none; b=cBAjSRsiZkpOo9gcmXTfDr9qFgFL6aWjeZ2hQhPkLFiynyWErmE6GVHiD6oG/676trmGAhguNGM/jn1mEbzGzXsktOTaC+PXg4GKUNCth4aleNVjpj97uJkNn/RdyzY9/DR6n3V35+rEH4qKkKa4nAqxk3VrItKSYGmpSOjImjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253755; c=relaxed/simple;
	bh=ieyfvDKH3Tt+g6Km/oF0YWXewNAFY2nA/w5dLdkWUnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtQOAfaSEyWpRvLKAV3gYuOijEK303FHuUYkbn91vDaNUrIhp+Bw0uVWhKoCgUCAGKpOD/u+k+0e7ko7G+A91OsHXo7Rzi2HMrK3NcGyqaVikezWICxJzfVApjYx+lRX6JnP20p0aRhHNGbAss68YaDiAwJiR4yvKN6vHzx7mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUirXAm2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUirXAm2"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-709a4f97149so11061957b3.1;
        Wed, 14 May 2025 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747253753; x=1747858553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieyfvDKH3Tt+g6Km/oF0YWXewNAFY2nA/w5dLdkWUnw=;
        b=CUirXAm2gVGrFtXKdjxOAX+qV5VWUdHXhfAHv+jF3qip2O6mvtYY1Fl6JeDlwrQ3rs
         RtrfpLAM2vTGPTnrw0jEUFkS5A6kswmfeWxR4dYLNbA32zFgDvoPEhs/edwC7Q9LOs07
         PlDHuZ6K8hkwAfMlPNjiYyOYB41NyPuoinoKpLoBic8lWBV5MfJ2XXTOdUxhWFUwQ1w4
         hHlVn1/wZlXCtoOb1v/cl8fsd2VTa+ZSUD2YhA7mLrDPOqCsfPjIkKB8ZRIYG1/z2+ez
         eazyWti2hggFNAxlfZ32TuRf0EOOCGiK52TAj9iuhxLhgDvcAV9gC1nUOXExfB1JeFRQ
         mcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747253753; x=1747858553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieyfvDKH3Tt+g6Km/oF0YWXewNAFY2nA/w5dLdkWUnw=;
        b=Zno8AXtyOcDaKWVGVacDfucgR1JWyKs7gDhIMtXUSEy9V/7p9x+Y4qzUB8XrFXavpB
         CSUv5EvxIJGpmrnHB8PUo7VTjmrms8q6RJkQ+/7u8EYVIMwyxsjn7SQRD/NdwD82lDlw
         Let8f8MYYiD61e5wPLa0UgNftg/1gkPpk7gfqDByyEr+1giEKSd5wnxempZS9pQ7zuYO
         UKfw84RgxBIMQp/OUh6yxrp4kDFxzxNDheNsXneb768CtOKZ1wsRqKIacBiacDjH3OwS
         dk/ABPGKSLmeizRGwZz/0lcfPV+bQjmB0L2Ds5kZg02unw+Swq8gE4c489lOIMlqPoCz
         OOmw==
X-Forwarded-Encrypted: i=1; AJvYcCVQKIODQ/DTz5P7cqrRX9+PAVfi9oBPcRpTsQQXdmE3SSVQT1CjVqryBf3ym7C8Q/gqgr4609jusWl9aqM=@vger.kernel.org, AJvYcCWjBW2J0szypJ+DpTUS9WrWu9zbKuK3an78vZIP0QBMGwDvTuAfPxOHf0iSc9tHp+kr4ExTlgXRxntmKYNXzM8Mbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSx+W2DutHC+J4BdZ/a6Jh4DO8NtE7eDMhmA3vIjDcErryXtDS
	IZNaj5e8ManxxDzFh/qXPAxUspFFBveqEJ9tmLIsyHOsb+KcKL92ENbEXFqM08cVftkoCIN1VgG
	iFT+RnJFdno/DEzA04pDjZBsSFSa0Yaw=
X-Gm-Gg: ASbGncu6Ezel1G8WN/akmB0LuHcK/tNaBfbfmgs1SZLp4SW9+k9DC4i67GvEQqjYtNk
	kbBaZF34zTQ8IIvTJOjc6SCvMR+pgPaMP6koCBNaPNo3p1RJQo3xRuIdSD7c0+hJ2PP/AUcUsSU
	u4cUpKjl4r+E5vOC5lpC40PVHxNfXTIWk=
X-Google-Smtp-Source: AGHT+IFOOSjOZL5iEK1QRY+ztchNvmiMN9GfWBVhSD7ciQx9AFNwSjJpCGURNAbJE0PuPWPxSFMVNzDcsNYCoDAbQqE=
X-Received: by 2002:a05:690c:3507:b0:6fd:33a1:f4b with SMTP id
 00721157ae682-70c8fcf8098mr15190807b3.4.1747253753010; Wed, 14 May 2025
 13:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501022809.449767-1-howardchu95@gmail.com>
 <aBjfrUqFe444h_CF@x1> <CAP-5=fXMwyGm5KUecSS4pUhgBB_py=R_c0LqEYfnjyRrf4bcMQ@mail.gmail.com>
 <CA+JHD93FaugH5ny6+bBkciwoWzLN5RKCbtBq77V2bi8Rs15-UQ@mail.gmail.com>
 <CAP-5=fX8+nyvisxybD6gWBhJd=GpuMiBkSA+CqnLuUc7Mx2KHw@mail.gmail.com> <CA+JHD935y5ky0EWrG4okShjizP9JDp1hOoUiCNT3c6WUj0k1VA@mail.gmail.com>
In-Reply-To: <CA+JHD935y5ky0EWrG4okShjizP9JDp1hOoUiCNT3c6WUj0k1VA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 14 May 2025 13:15:42 -0700
X-Gm-Features: AX0GCFuC8RUg7OBCnE4NUp_-OeKZBEFLwQSN4xHj8h6GBU9BTam8I9U0_MK6xlY
Message-ID: <CAH0uvohK3ER-KODvgc3aApLOebR4v=SeprenvRxxbJqwUQW6jw@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gautam@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you, Ian and Arnaldo, for testing this. I apologize for not
responding sooner =E2=80=94 I don't think that'll happen again (these are m=
y
patches, after all).

Wow, it's applied. Guess I'll treat myself to some Kung Pao chicken tonight=
.

Thanks guys,
Howard
