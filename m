Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08728EA76
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297995; cv=none; b=OA0r1iIB9aYFuStGgsUQRdC/5oGp8UIIl3xP8Te2CTeYhjmrcUgGow6jeeBmbrPbYB7sDImOD72CqfDW+RmmB+xku+zAXKvyrpixXvsqOBhfSD/QFu8MD9nkg/l54A7ZOjxAB/QET/4O0S5mK7qn4vsjQWB+yfFASQMlcqntxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297995; c=relaxed/simple;
	bh=3w63HtcrTJ91JYwdGPTwy1GlgEB58Nzr8tG6+Ue5pOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnLPfKdg119UhK/aP13DmOGyFaPDxmRh2gTavIULVYkmdnGYZXbF4+GHM9b9ju2rZ5RJaxDqvPvnifZGf/Taq7/6PN4ZHm6PkpbXmrZWrsds8CVkyYxWDvkKhNdi+tjL1F8zAMcau2E+bK27k4Kwpryru3BcsEocaN3gQejN1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eQBEW++; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eQBEW++"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so531565ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751297992; x=1751902792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w63HtcrTJ91JYwdGPTwy1GlgEB58Nzr8tG6+Ue5pOU=;
        b=2eQBEW++n9SvD07n9szVeQCXHDN5flWmK9rIXRKf1mHHrbvmwluudTar7JiDhmAfUo
         +/kDOlRn91Kb7VVuLOsun4SPXTzF6UpxW7nT2Von18z/VF5AuvR9rNIpfIji6hCpGHrM
         g3iia87lDjcRuOiOhB3dBo6maiE6Fc+PMEBibzHJYvgNgcwNhmhxbTpTPH292adqfNfm
         3K2KxJqH43VgnEyKbui4sWs1q4gDAZe22+1RiEvGpDECRo7er8WwxaFuC5pw23QN4XVn
         8xtc8En3w2sIK/X5wKRn1Swqsr7awRzMVHLzkySp+5DQ2Cgtslk7Dj5FVyDtbxcp5U6H
         zgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297992; x=1751902792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w63HtcrTJ91JYwdGPTwy1GlgEB58Nzr8tG6+Ue5pOU=;
        b=SC81AmyJ8xxP9FwJcUYX4w3q1mmDp5b8UmpGNu3JKINhYfwa9pDdY0Kq7/YeyHzf9A
         jL758mtdyYfcktdkMerLJu0bjmBQqyOjbEy4yWp8bt61XJW82zzTci9/ck9phREat37z
         YOkJhKCcxVhpXs77pElphZnjfyj3Eo1Hd5xdlniJu+K5qFEy1fdw6NmS6HtUMUaYB7X+
         uRDXkou8pjbhraBaxLq9PqxFQUPgUHdknZkVtNz8+gzNm5Z0Z2FVkvEMpdNOabzEKEXN
         oDXP7ynOiJs3JKXDHZeV5xrcC2uBNM1vaODbPGZLNQefUBumm27bdYTUCq1Tdy1eI6Sw
         mfTw==
X-Forwarded-Encrypted: i=1; AJvYcCW8DH5vi640ZIBpZv+0YBM1zCIRfPhVn0iv0abPNCVdh8pegLLMAI+MBODyxun/uWS6aw52GDXm8CEnVHzOsHJP@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrOozsqRfJkSNY4k66rIYm60xPMCJqLtglOLZHkjoXKw1lUI+
	n8Gg3MA43gmCQlA4ra5omXFy8GNI5cmuk9Fcc4dDdWRb2AqDn/dkgLrzvE1ns/WUZewIP/KpO+g
	Bpthgc0m0Us8VRbTCLoUJetaWbUxnm003D1B27N8e
X-Gm-Gg: ASbGnctzAL++Dij40nsqp9C5L/cMdOEHlvxxKVLSzlyGjwkopBY9nX2LIYnjjJWovYW
	VQO8wtyWopflimelVbYSmb9yiEBr69Z5I9SGyqqfvZHkNofLHSwtS1KqHHtnszIanm8pXpC9Bhe
	l8QXlCdX0C6cPAdD0nUb+58Mw99gXudVqUpuPBA97v4G7aEH3k+srz/gmzzmrpfM4ADSLtGKviN
	4ta3j0OWA==
X-Google-Smtp-Source: AGHT+IE3Gjk62YQq72+SdA23cor3rISzp+2vi5ogIScgBjQ8JLbbC6ZC7DtLKd3NdBa5DEDq5THLgobbPpD7gEYD/hQ=
X-Received: by 2002:a05:6e02:1606:b0:3dd:cc4c:382c with SMTP id
 e9e14a558f8ab-3df558794bemr7428205ab.24.1751297992362; Mon, 30 Jun 2025
 08:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com> <CAP-5=fVGqnWuQNYM9XULyLuDvx-yAuyCMRh=uS0gybiEsYH9jw@mail.gmail.com>
 <fe821704ddd4a3ae5169ec974cc8cfde8dc44e7d.camel@intel.com>
In-Reply-To: <fe821704ddd4a3ae5169ec974cc8cfde8dc44e7d.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 08:39:39 -0700
X-Gm-Features: Ac12FXzCbmaQnlvNe8l_BtMCouk1SBtEALi3aMKfEu6hBpoEXaSqQxQQetV8l-Y
Message-ID: <CAP-5=fWC_buKxJ9aSOWeRY2Z+NrhQy0QvVWaMLJa-Eqfwf-NHg@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] perf vendor events: Update Intel events
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"Baker, Edward" <edward.baker@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"mani@kernel.org" <mani@kernel.org>, "acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:21=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
> Hi Ian, not sure what happened but I can't find this series in my inbox. =
Could you resend it?

Will do. I'll rebase and send as a v2.

Thanks,
Ian
