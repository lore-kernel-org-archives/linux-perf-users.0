Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659658222
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941002; cv=none; b=RLSKi1gAxSJ2rdSvXQdS7NB8c/T2O6WVeWtHBpA9fzTtDPUQ96tvsT4S/6W5sQcTTuclximzDC5IYf5hPu+5WaeUu9mdimhuBuJdzBYD0E91CHDocs6vZDl9M+EZ68ni4p8gR6jhw78rBTvWWlWM4ZBQUyhXObbA36VUXclTwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941002; c=relaxed/simple;
	bh=wPZoaynhl5c69TE6ENIA3vBAXkfVzfAwSAPEdJ3mUA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE/AbK7ppnEEKP6bjCEAR0BBzffD1KfbAW4lC2zS4PFil0AZtJz0db/CLNqUdojpP9khCjyapD0CHPyDCFR+Yk34n06eEolnsCQ/3efr5UImkgsWmk9w72UjEBHGg6OJj/9LZ/cFAPWiHc7daPvXJtZwmEm0NX2KuwMIYXEoWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdczGLm4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdczGLm4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4aff530dso595ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721941000; x=1722545800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPZoaynhl5c69TE6ENIA3vBAXkfVzfAwSAPEdJ3mUA0=;
        b=XdczGLm4zUU84sDMXxDvcaz2NjGkbP+CRs8WhZ38+ZrMemouD0VHJtVKe4DXl2EQlh
         wFaRsUENo9TTKMiqSzSWcwAnPEPitk7Fxve3A4hxZIX50NaPXt5BboaPgyH/h5w+6Tl0
         jNDoofr1B3gSZsc+t1Nn8isJtP6gtv3Ci2L5z/yhwuvnLRZ2ZwtacGZZ6U1ldMD+l0rP
         QNOKKzyog4Pu+xx8UzD2re8mKIHqbnPev4ipin1Wv5sRNWlDWN2SgXUJ1oPJ8efIr4Wx
         xB5FQHvb++agMyZGWjtTzDJegvRsOT5A9F4tgW9Kt1rlOBD89m/ljC28Sd8M933ffZ2t
         A1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941000; x=1722545800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPZoaynhl5c69TE6ENIA3vBAXkfVzfAwSAPEdJ3mUA0=;
        b=QNmFxAT8dhmeYoFW9OGWmDqq9UdMpmMS4MHpvD30QBDvE8SbsHlkZ0Ea1CV/5i5Ll5
         oGixyAWmIufiTsinca6wQQ2OztUjLSCRQzsAMuKZPrE2PgP90yl0xv74hSV1ptoNqRWV
         FArU7o/75s/4S9y1VCuyE0YXlWxqavkyGj54Opcv8ONDmSXUzfEHKkZZv8HKjrvg3Elp
         n+eU8+E1UiMbRaxpE+fZTVuSNnlLAkRoi2SyMM8fVdU4QybSVaOLkyYmQ6QiuaG5nPvd
         ZmP9cHrT2ATV7l8TRl6tpqAfCyJpUTmLkjh3R3d7HcqhvEXvhWHifeiKd8Tbb1VRcYgx
         s1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWWQ1Rdpf2TEfxDRdXe7ARKcU9JdT1ehubD79JJbSauXeQA+MF1JuEGUzeSd63XWBzUXlCoH/GELKv/b4Tv2eJx2oqE7kfYyi4soJObMAOhag==
X-Gm-Message-State: AOJu0YyeRfGQBhSpScV7SYMiGI18bNLDvRdD+QRWfTBPv5+qbPKbEx2z
	chdbF00QvRTcrkB6C/C+gOQ0/FqwXKmsxTIjNrSIoX352FQn8mdvt7+LwS1rmLwY/sVvXAIHGvs
	/29RDuKGICgb6HPzf7YfvNZtX0ICz93LoNgTU
X-Google-Smtp-Source: AGHT+IFG80LFivM/nskrLupfrShOMIXCh7OLFCeuRjpcLkQnabK6tCodUPKbnc8iXb3KMPiVFPttqyyUx9JgTuH2iDY=
X-Received: by 2002:a17:903:22d1:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-1feeeafffa2mr672115ad.5.1721940999590; Thu, 25 Jul 2024
 13:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
 <ZnRP4hJLcRpZzs4x@x1> <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
 <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com>
 <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com> <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com>
In-Reply-To: <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 13:56:22 -0700
Message-ID: <CAP-5=fUbJcxO=h65bqZ2nx8UTPHsapOVsfcCaY=+q4yO9YBY-A@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Office hours tomorrow. We're 1 month away from the end of Google
Summer-of-Code 2024 [1] and Howard has been working on `perf trace`
annotating using BTF as well as improved off-CPU profiling. If you'd
like to discuss this or other perf tool topics the details are below,
all are welcome.

Linux perf tool office hours
Friday, July 26 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline
