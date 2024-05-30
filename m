Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0141A94;
	Thu, 30 May 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088892; cv=none; b=fPGcWt8rl8uQO5uEWbPAh8x7OnjUXVEM6pomsTaMgIw7JXM+chzoiEyU01uu8eksnfwjG2Y+dT7x5XgaxmduxqJXcyZeGl0ZHZ45/TSGWQuTuEsLLKS5di8MI3yhDsAR6AFWKaDy+gg0hgkRwI6pYHkTslDp3M/IL+lcPcYl28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088892; c=relaxed/simple;
	bh=U0JAITmVlruEvFktXlP10wzX6bVnrYcndvpUGt7xU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPqtpNEEHgCTb3KpxNmK+IxusEAGW9vQpsxMpb/OEsj6iRtPYD2ODY9UacEcS3/Mz97IEBVP+aL8S31+XkHI38grZsn9aUEqsDEeLHpTIfjHMOVOlxDIHW1hgobSncUlZDSBD8EH2W0IN4/u3owxlACPjOeEiYU7kQA/dHbEA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so718772a12.0;
        Thu, 30 May 2024 10:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088890; x=1717693690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJs+BqLl3GEpbeHEz0AUVZacbmEagKEINcpOIf6Dfb8=;
        b=I8IlElouoGk1znUy5ihX0GS9z50ps0NPm5P+TMRvmcx/nZ7pCmap/jR0YYYWwhcVD1
         5xfQGtaG7e6AM/WYqw3ateg7jqENGFcDRvH7ELUP6O3yY4YjNmUTqdSXOSYwkYbU6/sL
         EpnxY7R6mZHq4aRYwlJ261dm54xbz21E2RvhGNtm7aFxkpd3c8CNLv1mhK8zbeq6LpI1
         M3ac8UoUjFs5y0a5exoq2FmINhA6tu7dMdYTMNHhLttf4sOr9RL93IfmDdfGrvg7Wm7K
         fLZ3m0czw9pbodPPTaFI9WHJ9zvzLHY4bz15yBbf1wWbrFUfxXJ+PLIAVn7KUnkpsoHA
         g5+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNaSom3QJ34LWCnbgM2WMOfchhTF0QHORxX+kkm6pLo6FFIGPARp5OItypYNg+JmQKCFtuTvobkKCCSdHIIGKxOr3OwXuhLs6KHX2k3RL/nRhmygCGGc/PazgG0N2xBxRV709q5wGg7AmSfGKUVw==
X-Gm-Message-State: AOJu0Yz8ih9CqL4JuH2UM7FWZPEawO5FZo7uClwhMbcQkoXHdJqI1WCQ
	S6c7084YwF2IghAifaUce//d6XvbI/4Vlz3XdRqGI1d7NLvpO3Zvkv/0Tf5x64Lw2A5ZkkRKILZ
	UwgprW6FlTI7gXMEvIRz8dYgKp/A=
X-Google-Smtp-Source: AGHT+IEQwAr+WQBfo43dtj3LV7XTvnZBHx7RxwF1JdAU8GMnGX7kt6+5tImKtWnVisgs7G6k7WPplMAxUrSQ6Nap/0s=
X-Received: by 2002:a17:90a:7086:b0:2c1:99a7:3cb with SMTP id
 98e67ed59e1d1-2c1abc6f897mr2724064a91.38.1717088890100; Thu, 30 May 2024
 10:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519181716.4088459-1-irogers@google.com> <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
 <CAP-5=fXME3cjNK-P9qk+kY0dA1Xkwvz6Su=99nY7CgcKrQTb2w@mail.gmail.com>
 <CAM9d7ch7GidVscUxQh+CZRuo1U1KiDiFiuOZN3FnqbrPDbaVNw@mail.gmail.com> <CAP-5=fV9a2CrM0suQ7_VgG=6DoAAi+A6JyTK=kVivNmSZmg7aQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV9a2CrM0suQ7_VgG=6DoAAi+A6JyTK=kVivNmSZmg7aQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 10:07:59 -0700
Message-ID: <CAM9d7cjM+rUrTcd4juwUcjVAewhczCyoupko_bHZidWfOv6dpg@mail.gmail.com>
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:02=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, May 30, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, May 23, 2024 at 9:47=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, May 23, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Sun, May 19, 2024 at 11:17=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > In general a read fills 4kb so filling the buffer is a 1 in 4096
> > > > > operation, move it out of the io__get_char function to avoid some
> > > > > checking overhead and to better hint the function is good to inli=
ne.
> > > > >
> > > > > For perf's IO intensive internal (non-rigorous) benchmarks there'=
s a
> > > > > near 8% improvement to kallsyms-parsing with a default build.
> > > >
> > > > Oh, is it just from removing the io->eof check?  Otherwise I don't
> > > > see any difference.
> > >
> > > I was hoping that by moving the code out-of-line then the hot part of
> > > the function could be inlined into things like reading the hex
> > > character. I didn't see that, presumably there are too many callers
> > > and so that made the inliner think sharing would be best even though
> > > the hot code is a compare, pointer dereference and an increment. I
> > > tried forcing inlining but it didn't seem to win over just having the
> > > code out-of-line. The eof check should be very well predicted. The
> > > out-of-line code was branched over forward, which should be 1
> > > mispredict but again not a huge deal. I didn't do a more thorough
> > > analysis as I still prefer to have the cold code out-of-line.
> >
> > Ok, I don't see much difference with this change.  But the change itsel=
f
> > looks fine.
> >
> > Thanks,
> > Namhyung
> >
> >
> > Before:
> >
> > # Running internals/synthesize benchmark...
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 237.274 usec (+- 0.066 usec)
> >   Average num. events: 24.000 (+- 0.000)
> >   Average time per event 9.886 usec
> >   Average data synthesis took: 241.126 usec (+- 0.087 usec)
> >   Average num. events: 128.000 (+- 0.000)
> >   Average time per event 1.884 usec
> >
> > # Running internals/kallsyms-parse benchmark...
> >   Average kallsyms__parse took: 184.374 ms (+- 0.022 ms)
> >
> > # Running internals/inject-build-id benchmark...
> >   Average build-id injection took: 20.096 msec (+- 0.115 msec)
> >   Average time per event: 1.970 usec (+- 0.011 usec)
> >   Average memory usage: 11574 KB (+- 29 KB)
> >   Average build-id-all injection took: 13.477 msec (+- 0.100 msec)
> >   Average time per event: 1.321 usec (+- 0.010 usec)
> >   Average memory usage: 11160 KB (+- 0 KB)
> >
> > # Running internals/evlist-open-close benchmark...
> >   Number of cpus:    64
> >   Number of threads:    1
> >   Number of events:    1 (64 fds)
> >   Number of iterations:    100
> > evlist__open: Permission denied
> >
> > # Running internals/pmu-scan benchmark...
> > Computing performance of sysfs PMU event scan for 100 times
> >   Average core PMU scanning took: 135.880 usec (+- 0.249 usec)
> >   Average PMU scanning took: 816.745 usec (+- 48.293 usec)
> >
> >
> > After:
> >
> > # Running internals/synthesize benchmark...
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 235.711 usec (+- 0.067 usec)
> >   Average num. events: 24.000 (+- 0.000)
> >   Average time per event 9.821 usec
> >   Average data synthesis took: 240.992 usec (+- 0.058 usec)
> >   Average num. events: 128.000 (+- 0.000)
> >   Average time per event 1.883 usec
> >
> > # Running internals/kallsyms-parse benchmark...
> >   Average kallsyms__parse took: 179.664 ms (+- 0.043 ms)
>
> So this is still 2%. I was building without options like DEBUG=3D1
> enabled, so perhaps that'd explain the difference. Anyway, if you're
> more comfortable with a commit message saying a 2% performance win I
> don't mind it being updated or I can upload a v2. It's likely this is
> being over-thought given the change :-)

Nevermind, I think it's fine and I can touch up the message. :)

Thanks,
Namhyung
