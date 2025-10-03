Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5326B742
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529446; cv=none; b=n9f039nO8MnAmo47SVzHeKxZpUbapdjN8fx+a94lIz6ay9C6wkFFaIgAr1yJVjTa1onfvfDliYz6FvwuYWTSbiMjhigXazJnUqtT2Z4tj0YZHlbC6kbWfyM34W2zq1NtoIU7rs7wqg2DJhwNBA1BNKuUaIevDou9cnt7ZmKASyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529446; c=relaxed/simple;
	bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCQEln1JQmZqvWXlSY+Xci+p3dQziUeWnj2rlih6NgchLjr348skB83Qn2gguMVblPWbjbIKbHB80I6IgEp0a709ktzEQhRsdI7lnatXr2cemlk/B+1LMu1ebgYl0HcZ8uQ5hz5u7R97YpiaTPrCoiwr3lpQOBIR81XJaPdwYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjtrbN9E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjtrbN9E"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2681645b7b6so27835ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759529444; x=1760134244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
        b=vjtrbN9Ejen1vdPduqG8rNi7IpxNs3fPe+445nnRniDQBqzvyNqSGS+1tJgiyJo5ch
         qW8YdMGeKD5fAf6W4iBbmoEpkJ4K6W3L5b14qrz9AgA7bC6ACgrm7wpMSYyiuQL7zc+T
         YxnwfTBOTuTrnZjiT/Guqc7MDbffeKK45D6qUBTP7TMqzbaaPfCggu5Auv18cTeotX9s
         /6ayiyBceH+naQy99n5Tkzus7iOe7pzvfZMky1JWYMD77hyA3U+hAcM/CqLlqFBt41QU
         trAd1Gjp7moDTp9GGIKCcVppwA+U06K5kuANtIWxOhj5HPuyU7iSdK0x941EvjNOUQ7V
         G2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529444; x=1760134244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
        b=oOmt9z/SdkI14J+5EnZP8uTezFAPIyJ6bCyHT/FjnByQZK9J6Gx6eLOyw10J7u6XWb
         pz+ZhFkTyY5Ofoic6v695+fZaG/cmtBjURX50ZaFCqTBuML8J0ZZqWHjtZhEyOPojyIZ
         30+ZYq2UpP7I4gMUJYRwHIFI5R9IthSg2BGQMeWQogzlAXXNlN4/ymvq7e1JPYpoZYHU
         82jFhjfT1CFrzAG5jpa95TPeuefqWFt5aseUDX5+jfdMqZeETyFlAzpg0JwbpuVdroqP
         Blyl1KLaQ6M3JF17Jw2v9Kw1/etczy2d+C3KnrGsyQQ2kwLN+g0umtr4dd/aXBE83hbk
         PbgA==
X-Forwarded-Encrypted: i=1; AJvYcCW8n1n7G+zl5BWGKcOQwafQPGo8qwA4TKEEqstNou+ciPqOZYOm/CEa5c5TNZo62MffZlYZ2HoP+7ly5Nz1O/xj@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRan/M1Ge+SPmCheA94ZZK4iWh5+KgeStCs0uF6ICGASjNQ5T
	ZVLI0jRlKeVpZNexd1Ti5CBLjjebEz69kAJHrPj/hn9Ztcf9fqDuh700UQxDfbhlC+G984ZQA6K
	NblA/wCSkL8gQ6GzVdF9HxEbGOiQAFTa//CODe2uM
X-Gm-Gg: ASbGncvpeapNH9LAuiMcbYSjiOlaK6dI4AEYpCF3cWy3+56N1p5xF/uxvoI3J14W5wU
	jaueglzPC/YKcnp7DkY92XM7mSh+1JMw2BbDExLER4lnCl0zwdqhm04xWFaj+AMFTD4DYAFXPjl
	jgL/hHOzPxVn2RLqzPVhPAEamMhpO2fZQojJuGsrLGwy6Sb4J4JwTPF7prZCZDZCr6xQauzwnP5
	Okp9Vzbq3/UZgyL6x2eIfNYJkg15FDOF0Tozd0uLu45QCtefw==
X-Google-Smtp-Source: AGHT+IHTIkYhcz3yGT63jCfY6vWA+KoaTKDZUeq5EvU/4RPSdc9aI9E5foFa8pMoK3ht9W6OMqyEDWGmuRN1dR1TghE=
X-Received: by 2002:a17:903:19ec:b0:270:bd33:f8d0 with SMTP id
 d9443c01a7336-28ea7f63c95mr1388985ad.14.1759529443485; Fri, 03 Oct 2025
 15:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002220727.1889799-1-irogers@google.com> <20251002220727.1889799-2-irogers@google.com>
 <4a49c58a-4b07-456c-a2e6-67d04b905944@linaro.org> <aOAfPZch7tqNy9Pn@x1>
In-Reply-To: <aOAfPZch7tqNy9Pn@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Oct 2025 15:10:32 -0700
X-Gm-Features: AS18NWCjqoAaIyyP9ujehpFLwYIcZC-oq-rDTZKvlK7Ln2nmxMfmtf49po2v4ms
Message-ID: <CAP-5=fVLkpr11v4MRUgV6XQD=P1iRLix-NCY26TqJaCA3uqEiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Refactor retry/skip/fatal error handling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:08=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Oct 03, 2025 at 01:03:25PM +0100, James Clark wrote:
> > Reviewed-by: James Clark <james.clark@linaro.org>
>
> Thanks, applied to perf-tools-next,

Thanks James and Arnaldo!

Ian
