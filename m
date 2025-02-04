Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505302063F7
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629686; cv=none; b=R2eiVPdUcBY+43+D76riA9fOBPLsB0AN9nsWrQ8Xn6xHcm7E4DKGTOCspU3fhbm8d908tu8xq+iRNUBZZu6LJ16oAvb7NHhcfsnUiBVm08i2N1BpzXWjCwVuK0cF6N+BpH2eW8lrAKz5w0zCpIAbtMDDZ0KmZShQM3YMG9T0UiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629686; c=relaxed/simple;
	bh=sKcFJXJTh7oTyqsaZX/BZ3E/a1+/rxVAjCiwpUZmKLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc8ruiodXh+oDXViPU5ANbbiX/IyYMjfAKOzJDSNinBHlmC1/KUywO+kQ/q+G7dRDaAvYN1mHRx+uPNw43rdEcFCoQKu7Wxw8k0m1l7qXE+/fk64gd2pQaw36nRRHsCzig0rvhWQFUtmwiY6LjDy3nKNfIdTGP5ATxduKFIoJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvqAkjbw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvqAkjbw"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso18635ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738629683; x=1739234483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mNEpv7gTbB0335b8JJb/srcBCNEtj77NuFnLzwPBSE=;
        b=QvqAkjbweU5QAmZncXpU2LDrHVSNYT3vMBKPUUF1EWJP/SOmYuAzZSBoOr1Gj/UYAk
         oxjH3tZaTO3QY9XQdpqIxvWmzLDP6e6pSCHjWVxXCsS6dNFS7YQffY7fbusMWJ0HIROx
         9k3hWjcm7yXoW3zReblrVvwepBAUGpaE8oPooOfHvYlRaFIOL3u8jNgQbFrV1yHtW2MZ
         miywLhc4RAWXiG52dOhDL9f5FnEe0Zf05ctL23ifuwK5RgupV6vgwvHcPNpivSxUW8a7
         FfLPpWTKCxlCHtSBZakjUU/QtzYQp980hUeJKSUYHk84KU6jHoYj0vb9AKhUfc6gum8B
         ILQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629683; x=1739234483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mNEpv7gTbB0335b8JJb/srcBCNEtj77NuFnLzwPBSE=;
        b=vSnASZg31QN46kdlgPuNYHzEUqUGY82u3nZ7irPL8O2fhlrFkJvD7BP0KXOkRcpDm+
         WK9UgpbQGUrD8k7BeJSefU0jPdVAb2w92owh4A6AVXvyitmq1b7z3h7FJnygsMeWSY9i
         lXqZz4gNfZseVlZXeuL1wNzN4G5p/uvnr8xqCeas8s0Tqx8RAC5SxmzT8dZhTwOz8gWp
         Z7yFAHvcGoEK/IipdIjbcFbYigPYknNlYugSB6GUajS8liHzT2jq1sP1gVIOPlGEyng6
         pOTCdZ6w2Pey2uXLo82JoZZzNv8pD8COIbkDWGa2R7PB0cAOXrIojBthWotuL3APoca2
         yUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVLTcsfu1B+E8M/6AslI1RI+jr6v1apfFnpSO2CXa5rCtPojXqGPWfTjOlfkb+4wYk6eTtPXe/Jcz9wFHx2d0lM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70uggskezklQtb0ma/XH8fTj/zo2wUcq4yiazwiDE684bbEF/
	0mFR+a0AzVERP44H55D1DxzOOeOVaepz8qAWD5+veEK7oZK0cmcYr12STxnbxag/lExlqTPHpIW
	5j1WDZYXy538Lp1dyKc6dUSvYlOmBdzbNpnn3
X-Gm-Gg: ASbGncvHfX7+hjZsxCkP3W56uAfjpxcWKzRqvSAnX/T1F/o0RdKMDaRe7aF0jG8RE+w
	QmbDfsb3peD4TeHc7JyLAOZjDpFkmO7G269c+rkgS27OVy1z0WHGUJUY83mNYJDgQ65RhJQw3Ug
	==
X-Google-Smtp-Source: AGHT+IFTmsdSrUWZNxyWfmEinctbi+w595ub39Ewf18wox3LV+/XzMdJuttm056+xxql2GVcCqEWSyo+2i00MgHicOg=
X-Received: by 2002:a05:6e02:1c82:b0:3cf:a4e4:8f85 with SMTP id
 e9e14a558f8ab-3d040f52f90mr736155ab.7.1738629683115; Mon, 03 Feb 2025
 16:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
In-Reply-To: <Z6FcHJFYGc7HzSna@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 16:41:11 -0800
X-Gm-Features: AWEUYZlTHqNw7TM6SlCsxIdmp-h0z8pnRnASzLfQef6fDEaFbRsdhgx5tvrKk7g
Message-ID: <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 4:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
[snip]
> Yep, I agree it's confusing.  So my opinion is to use legacy encoding
> and no default wildcard. :)

Making it so that all non-legacy, non-core PMU events require a PMU is
a breaking change and a regression for all users, command line event
name suggesting, any tool built off of perf, and so on. Breaking all
perf users and requiring all perf metrics be rewritten is well..
something..

Ian
