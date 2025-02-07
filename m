Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE06FC1D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928679; cv=none; b=Nu6Oy0zNUVuG7QAjfOnbU72HCMo00nHi/YDwY0wi0Wggi4N0BfnYiYMz/Gv5fc4JGhCqZTYq6rEgwwVL98vGd7JNCqhvf220KNiCUILQyB+Slzd8Ifu1ZEnw8dTQt+qxRwaBcmnxPsK6oeJLNeBnnCGSb3gsc+GVU+f9qVxtd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928679; c=relaxed/simple;
	bh=JGu5JKj8jpkSVK3yYAVXPTbMrFO/6XIzUyJoj353e50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mh5jl36xgX6o2RP3QAbvqbka+YYMmcDC8SGh58FE0Mgo8NXufNuMNOiYRYHzj5wrYSX1huo4oFJOcKrZPyuPZdZACeO6iQ2WvGOW3uKqE5F9uuTvieQYJdxgmH8euEoRdLxSCQKt7fLK4xzzubzeb+Z/omsIDXJ0S4O8Z/zSNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oXZJbCm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oXZJbCm"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3082334d1a0so4994101fa.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928676; x=1739533476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXlta8LjLzGu/J5ZyrXnJulBIRAv/5fz0j1rTgufk1Y=;
        b=1oXZJbCmfxmJNPNi6O1mHtivr84eVIXwahsR+6TvyZHHRlYkB+eRaKCqRYZqzjhp73
         uFOt8h9ZQnJBop5c6FzTt1rk8v0so+OaEopEpY5u8wRjCzBo/AMsGBWEFmi05m4CPWRi
         9g/SuERpGvOEipNgFKEpSgs46i1jHfwrKlBKl0GOn336YIM8B0wGfi6xvTdB2ZjcBUSp
         xPmV4+xmUCMm2tgZgFfM5HSv5Mt7RmzJt/iHYYv0Qk2+SDqoyISeMym8DINNV9zycUV0
         O/Kk4NaAA7Uz99kC4xJbJdnliPu1tyTtx8Xmb+qJfpmmSjUoo/ZFo+kdL1j0XmY2/Tkm
         7AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928676; x=1739533476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXlta8LjLzGu/J5ZyrXnJulBIRAv/5fz0j1rTgufk1Y=;
        b=qFZ1ePFIctsDD0lyffazt2O/wgokJdfrWWYd6eZcUZvIUTTskU6aO8pjYvA5bbutVF
         XuR2SSke2GHU0nF/kFbUmuDMYw9ppNJFU7rNSqQgBhhIq7WO8ZUN48qf53IK/VTPQdHY
         Ld5KQ2OwRZ7Anlck59640q5Jdsy+l0MMbOrYh8UL00/OzVvkyBYtso3tPMSkBU+4h83b
         wmCinFNPXsmfttuoehjgpIY7j/0v19ZJqG1CZiRrwonB+llMhlvz00vZ1U2dvoJXMYjz
         7V0L3vm0uwpIM0xfKVS9kd++K85gDr2HOGUAwXHVMZmiWzUkQ1/zv86Fmd7g+x+Ka56s
         gc0w==
X-Forwarded-Encrypted: i=1; AJvYcCUtd3MU7b455vXa0Ccdw4aaG/aetibQHuh/BN8Cf6P2zQ+QGRtO3PumIHngrCws14RLlkPy8SOohSoa+LGak6XB@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbp1VQLhH7mZYaep6onDga/0clbBMqZCPHmTIa/LAfnzgr9z+
	cqKFsfOYLac9qgrcrzwr/t0erXEsjOixOTSeB8RQUXKomvJdb0CYpRDc/T0Wo/CHGbaPCJ2jGPC
	ZXm2U0RDhqJGa5EaPLKji7KpfgSbyd53jfhh0
X-Gm-Gg: ASbGncs4iQtW3CtpY7k4lSDz3zpx12Nohj2UbNutAxtUy7rG1xJtsiXAmXhh/qyBEFA
	i6uh0lNlQESEh83q2Nj3zsCCciVlkO/250kD9SePTbgkPVT40cNV5+IHI7edgGQaQEzqgdEqWOL
	IUtEFP6Y9cWcEx0CqGeV/ALD4H50U=
X-Google-Smtp-Source: AGHT+IFBD05bWatFNIOO3CjU1frhz0tzz0FlpHNb00Eyed6A0AXOGuMdcR8AEQ1ya2IawmyznAQ/JPQadiMtzM4HLe4=
X-Received: by 2002:a2e:900e:0:b0:2ff:4e4b:cbe2 with SMTP id
 38308e7fff4ca-307da58e04dmr21221901fa.14.1738928675866; Fri, 07 Feb 2025
 03:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
 <CAP-5=fUxY1KYXN-HcJPd2D66j5cC6DFTGPzYFVvJKvBLqyz6-Q@mail.gmail.com> <Z6WEkAPxtpVmx8cO@google.com>
In-Reply-To: <Z6WEkAPxtpVmx8cO@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 7 Feb 2025 12:44:24 +0100
X-Gm-Features: AWEUYZknqnNJQVXcj50I7GgYjjXVJVRJ6QKmq5lQDRQ69NY3CN35CUU5DSIPf7E
Message-ID: <CACT4Y+ZrFOWZodAM_Ay5hZRht=7D5KWcK7q4=DBpf-E2vs+JmA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 at 04:57, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Feb 06, 2025 at 10:51:16AM -0800, Ian Rogers wrote:
> > On Thu, Feb 6, 2025 at 10:41=E2=80=AFAM Dmitry Vyukov <dvyukov@google.c=
om> wrote:
> > > On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
> > [snip]
> > > > We traditionally didn't do it, but in general test coverage
> > > > of perf report is too low, so I would recommend to add some simple
> > > > test case in the perf test scripts.
> > >
> > > What of this is testable within the current testing framework?
> > > Also how do I run tests? I failed to figure it out.
> >
> > Often just having a test that ensure a command doesn't segfault is
> > progress :-) The shell tests Andi mentions are here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell?h=3Dperf-tools-next
> > There's no explicit `perf report` test there but maybe the annotate,
> > diff or record tests could give you some ideas.
>
> Well, we have. :)
>
>   $ ./perf test -vv report
>   116: perftool-testsuite_report:
>   --- start ---
>   test child forked, pid 109653
>   -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
>   ## [ PASS ] ## perf_report :: setup SUMMARY
>   -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase sk=
ipped
>   -- [ PASS ] -- perf_report :: test_basic :: basic execution
>   -- [ PASS ] -- perf_report :: test_basic :: number of samples
>   -- [ PASS ] -- perf_report :: test_basic :: header
>   -- [ PASS ] -- perf_report :: test_basic :: header timestamp
>   -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
>   -- [ PASS ] -- perf_report :: test_basic :: pid
>   -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
>   -- [ PASS ] -- perf_report :: test_basic :: symbol filter
>   ## [ PASS ] ## perf_report :: test_basic SUMMARY
>   ---- end(0) ----
>   116: perftool-testsuite_report                                       : =
Ok
>
> Thanks,
> Namhyung


Thanks, Namhyung, Andi, Ian, this is useful.

Added tests in v6:
https://lore.kernel.org/linux-perf-users/eb8506dfa5998da3b891ba3d36f7ed4a7d=
b4ca2b.1738928210.git.dvyukov@google.com/T/#u
