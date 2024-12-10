Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4023ED63
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858681; cv=none; b=oUUYnlMFlX1oTM/9TKnRHEL5tTcnSYhXf0/KSupHzxAZ0M+Bcr4cqELSCek7bjx5nC6vAs+AM6Sc9pBBx8jkfYW8B3lkfto8W56svzCftKtUtUjGkznBURqpYZYPUpaE2Z0A2LX/eD+TCmB3IfKsBtFBvNl4a9aNMV6uPWryVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858681; c=relaxed/simple;
	bh=wHazKxpJJ9Mpp4ZGU/vlkDthk9ec62y08omFW08QEB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlgBa6T7TxiZZ7f230CQr2or706+rveqqBGPsJkd4FZfYFuvmOc2bVTZ4p2HiE6VzgFRKPPHwbmG4PqN9zdeoklDA0Zsc+wP95J3FenEgMjaNJg1kQGjGthZOqdfmStFfNfEeonK6neWpc3ylZ+9pSAaFV5JPy7jI4peNs6u4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twXyuEm9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twXyuEm9"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so16145ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733858679; x=1734463479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA6uiztyFHUbzaCAlvb0H4MHj6VifXu4SlKDCoeA/xM=;
        b=twXyuEm9CcSSACg0MgdDEsx3Rk8oYtwgdrXdIt7AvSfSvT0YPSgDOzlOx3xKl4B1Ir
         B4e8UPUZl2Q010TevaB3NeIrb+YnVWx7eOZvEkcEN3N0ZHZ7SamU4fLJqMekzzk3hakh
         RBj8maqRcFXfsjmNNP/b4l4XKtrbB2Ox4UEJ1I7J+g8USZFDjVay5zL/AaBKM4r/B32k
         Z1IA//Qss0r1sXphrDRFdfzNN2QoJh6tKGrodh4ML7AQ/XBBRP0MNpwad1IrJAgvq9HJ
         wi5QDKJat+aIfpBWTZ048J1JzvxB3WH30qFxrmkXt0VH0gNds1e5wJjfnw0dASp/QjeY
         KZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858679; x=1734463479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA6uiztyFHUbzaCAlvb0H4MHj6VifXu4SlKDCoeA/xM=;
        b=NvaHFa+H4uVf375TF1AZcVWDefGNiA3oScH20z+fWqVuiFOrKbfv2qPf8TvpLhb8AP
         v5QYYbTBk4Wkjl+DFT6YZ5v5syf9kJlDWhv8p2pnX1B9v0H5m/hTMOBdjtmlbrpc3OFG
         8CDNlfJErCnKfJZggW+zr95fdL5HMBfhKigDz+zfzQm37O81/5N2FVfANOPoz/c5upD2
         5bGcKZiIeguEDlGLXgxkanZu75bzjOKxoG2uaI29y39jU1Z9rdbZwVXW0mNJZ1tpNfdM
         lifpE55GUcY3dXzZ+BzHOPQnzWmQUfE6KM1GPYlFhN9wS78qCdtOUXxZp8cZ4WRHqnix
         yqvw==
X-Forwarded-Encrypted: i=1; AJvYcCXB5R74DxxS+sPJFYgBn5z1RwjDBbUh5Ud2D67vXChj6eRXDT3/D4WZVju2QeaZt7NSp/qsYAFieDfIZNkD4Nqi@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4auAt2skaQJoFEJMloiC+Y7eG3SSshRpVvFXysDKDQeO+wu6
	6Lw4gw0NLLHlNwtiaoX4p9s4I8OsqrFHcxKJXIYNHZVA0e8pprH606sOLEMI5BhViPcZCh3pjmf
	cCHu5gNILccZygwAdI24K3qp98pF9ffWl8dWp
X-Gm-Gg: ASbGncu9pJN0bAXaa5hZzAjzv/rKoxT/rQspS+tUnDoLk0BEbwOG3/tBTtVKlBnKbpT
	cyH5+o/jCc1wLKJMH77TLq6MS/Ws1kktSlj/K
X-Google-Smtp-Source: AGHT+IFQdl6+o4/jDzSSu2u0KI/uMp73hkzZCGcfuo63dzkrt0UMs+yfVU8rjikFl8vCZUnCEA+64glRRIgoPy44Ze0=
X-Received: by 2002:a05:6e02:3003:b0:3a7:dfa4:9a4f with SMTP id
 e9e14a558f8ab-3a9ef4370bbmr368235ab.0.1733858679301; Tue, 10 Dec 2024
 11:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com> <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1> <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1> <Z1iTtJcMMsuwI0JX@x1>
In-Reply-To: <Z1iTtJcMMsuwI0JX@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Dec 2024 11:24:28 -0800
Message-ID: <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 09, 2024 at 01:29:15PM -0800, Ian Rogers wrote:
> > > On Mon, Dec 9, 2024 at 12:28=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > > > > On Wed, Nov 13, 2024 at 8:56=E2=80=AFAM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > For big string offsets we output comments for what string the o=
ffset
> > > > > > is for. If the string contains a '*/' as seen in Intel Arrowlak=
e event
> > > > > > descriptions, then this causes C parsing issues for the generat=
ed
> > > > > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > Ping.
> > > >
> > > > A fixes: is missing, probably this should go via perf-tools, i.e. f=
or
> > > > this merge window?
> > >
> > > We don't yet have arrowlake events/metrics, should there be a fixes?
> >
> > Ok, thanks for the clarification.
> >
> > > I'm just preparing the patches for the latest vendor json from Intel,
> > > but they will depend on this. I suspect given the size of the vendor
> > > json it will miss the current merge window.
> >
> > Probably best to have big patches via perf-tools-next at this point in
> > time.
>
> I'm seeing this after applying:
>
> /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434: Synt=
axWarning: invalid escape sequence '\*'
>   return s.replace('*/', '\*\/')

It likely needs to be:
```
return s.replace('*/', r'\*\/')
```
note the r. Could you test for me?

Thanks,
Ian

>
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ head /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"40 (Toolbx Container Image)"
> ID=3Dfedora
> VERSION_ID=3D40
> VERSION_CODENAME=3D""
> PLATFORM_ID=3D"platform:f40"
> PRETTY_NAME=3D"Fedora Linux 40 (Toolbx Container Image)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:40"
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ python --version
> Python 3.12.7
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
