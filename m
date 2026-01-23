Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487828B7DB
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187747; cv=pass; b=UZB4r/faNdsaCUZD8n7K+UsXy/F//GurRi/AZzHsdUhY1AHYKDFLCnpTo2cGQpUGJVpAh7HJoXa7lZr3yl5OUtnkrN/1cONR2nzAbX6ljVWVRdJzmWqZMJs+gbzb4Ug7wmZKc2rDI5kd2KRRa7Q/2+yLO8I5VtvYyRtIeNxGQKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187747; c=relaxed/simple;
	bh=DtM1uCUNEcTDDISlT/pniObKxvgAsNDYY8acJaYAkHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TS2cKWP0UuD1NbK00epvtgD3qjCNvS0NkuT2CIAJLe2kSweScwPrCLjXIWF4T4a630VE8Wle3jcy+V0YtrxGLwsWdvVGO2XVYpKyplRsqDdUk5Xn2pIwyzpm4bUTCpREaGeZ7X39uP3/nwTkR0a5RTH2TM/lk6V4jS4OEZ0VkpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWYM7eob; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWYM7eob"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233508c721so7842c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 09:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769187745; cv=none;
        d=google.com; s=arc-20240605;
        b=SpwvYjZ1rFNLzx/068n01QLi209ZB9iEpJLifiOhgZHQ4tALbkKannVlpbYiYFztsg
         B5Y4ngXk+ZXemidXiJqzrHT7AQJwGLeU26z609FqfHXWQJNvDrI8gSm1IxNWh8pAkSMA
         mvR+748jKNuPYSsq7Ix7fs9IwpJJnBWmREHIg4g2sE4HLpNu1vhj7IHxAtX1KpyEl/N5
         BNduLooYSRI8coAPfep9bmkwnXj4JD4pq5MhFf6ZNJ+VClwihkDkfkQF/z9JNvglTiKX
         wSvIip22piVGVcS9rpe6c//L16IQ7I+hsa3SobaJUFec4SOwTScr+E6B052frIx9/ErI
         h/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9tSuFjIF3+mwCf8Z/pK2tRMtM9rB7Bo+7CGl8/h5OI=;
        fh=HZ+u/MFdnuDYyFN/bjXMaBCEm5vwpHOZIFHmADAX2VE=;
        b=betj9+GerezW7Yc8L0RbfKCDQAHm3RJC6TYPpITvfT8dzGu7q34CUvGCWga8yFEXXF
         X8zE4/k0fLHe63kYjjjZADjTTI2sLgVcmtzPH3Yaom6FzWPMgrDN6iQR8FIjIrBNEDa9
         5pHgpyPG6SQ7HntfnZ0jw7X5O8bMMb22aLqe98GrHB/BqDF7OsaqxNs/A4qrXZKsr7PF
         HH/4gHU0vbpLCSw+8gci75vbUDZJIqK2VpaNaW60G9lJlqF9wRrrZTEyFsbotTk4n/uB
         02UysDnuc+8KmeiKwVPrzPjeNWjIb4q9ScE3CKPVnr66o5TXxsZ9oYL7K4Rd7SvxNfYC
         E+xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769187745; x=1769792545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9tSuFjIF3+mwCf8Z/pK2tRMtM9rB7Bo+7CGl8/h5OI=;
        b=aWYM7eobUR/k4YYttOZEbmsj/Fv9REwEII4rBOhvduPpa4Xnwz1c3rqe4swC9xZSfD
         RQDrT+9ZzN1drfbbJ0D0LNmUn/ii9n+/HHqSHmqECOndqERkWvSw687uYRcvx6uE9MIC
         XsbV6WR2JlfbCVjQkQ4Jvdpz1QIs7qkoBeC0kPCDPoFesXQM400AkXBoBx0JodcYEiBZ
         2bus/b6oR+XEmUqZlgwDusSerlir6Nnyj7AUVvDPlQg0ajjnNM0kU7jmjmhkJTVrjnr+
         LCVeoww37E8qOrAVgWowSbHsp0dxdLRW2Zc+0WUEgt0DrQfkMaZ1nVrl630nqTj40AEv
         QUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187745; x=1769792545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9tSuFjIF3+mwCf8Z/pK2tRMtM9rB7Bo+7CGl8/h5OI=;
        b=UvowEaKInVx65Ka9dQoUfXQhVaz62W2R5y2Q/94C04Yor+xW/3QonlvAkqAo9Dot/7
         ggQMSeSpmfKCSrLucuRMB+a+5Uj0bhfLNaYdANOa188ncmD/dSJVz6sc7ZHMmGOtTtfr
         SO9+evbVwlwfjfObPGzS/AtcWM2nDwiRaPBQV3awS6ieYUGEFuTe/pP2e0Jbhqu8VGGd
         J6Z19tkLcRZ8Ncw7KcwSSlhORfAF/+aYbiOHwEgGTZUOVpxw7P1XHx4v3KPuVBNzTr5s
         hgMb/pSQ5VrA5AX0790BRJTUcmY3vNTNsBixTTiZysSyrYJ2dtwWrnkXPy4PYasgf/Rz
         +4Og==
X-Forwarded-Encrypted: i=1; AJvYcCW/ygUV3sH8nBMetzkGD6hXW+yZd8L9kFREYhN7yZiC50NIPBTHD4rP8wXdCJ8YfdWdORjGngJ/pvc6Rh8KwXyb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+v67nNaCC8GGS5GKRZRrRbZe5WATzXByEpFAULd1LBm9kLf/v
	Mf5iAYuZXrAd+852nKvcuPxeATm/Aq2JQFtzUZ0Ba+8+NAe1yuAaySzbcYe05jUjXH3WpKC4CmP
	O5Yaqf5exr4W/vFpL48lshwOq+AoTxcrWsc8xUhdI
X-Gm-Gg: AZuq6aJ1F1eetgcuRR0BhjECpPokO+1ojFN1XAR/ua6q1cy6uzsZGf68pTwtnrtaQ7i
	wuymGNh5lOvg3V0EYByMLv+zdgVqo598iI19LMSDknqoxEPvqtIlmc5ZorIQI6YWefgBznmXoOu
	wYWJSPmM6pPb0KD+H19u2bLHU8VkwyOp/7QHgAQ6J6o+bScqFi3M1zqKC0N/NZlz9l/Xaea7Gha
	UWGN9LGNBCNem2q/NMadyX/nHoof4gt+KenvakuNRcQ7JchRphJF5iJldzR5O4Fk8ZxYorEhzbd
	SD2XpHs1Bk8lyGxy7z4OXrgUCw==
X-Received: by 2002:a05:701b:4185:10b0:120:5719:624e with SMTP id
 a92af1059eb24-1247ea81d0cmr89785c88.21.1769187744730; Fri, 23 Jan 2026
 09:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125155648.197527-1-jbrnak@redhat.com> <a5f59c64-0da-6928-7a9-c5b6c2be8ef8@redhat.com>
 <aXOh_4oN9P_Sxo8t@x1>
In-Reply-To: <aXOh_4oN9P_Sxo8t@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 09:02:13 -0800
X-Gm-Features: AZwV_QhsFaWRB-hs2DmPMbIcOcmNs4kKnSOQNnd77dwIK9p6cOzkjKtMMhKdszY
Message-ID: <CAP-5=fU3Xi1CT+YsaY+7Akq2Afh6m4hUwU3SkJvKPM2s1oR0ZA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Introduce structure for shell tests
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, Jakub Brnak <jbrnak@redhat.com>, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 8:29=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jan 23, 2026 at 03:26:54PM +0100, Michael Petlan wrote:
> > Hello Ian and Namhyung,
> >
> > kindly reminding this patchset. Could we get it merged soon please?
> > Or is there still anything to address?
> >
> > Thanks in advance!
>
> Just test applied and it went cleanly, will try to review it after
> lunch.

I think patch 4 has an issue as the clean up is in the wrong place.
There are also some file descriptor leaks. Other than those happy to
have my:

Reviewed-by: Ian Rogers <irogers@google.com>

on the series. Probably should get patch 4 fixed though.

Thanks,
Ian

> - Arnaldo
>
> > Regards,
> > Michael
> >
> > On Tue, 25 Nov 2025, Jakub Brnak wrote:
> > > Hi maintainers,
> > >
> > > This revision of series of patches continues the effort of upstreamin=
g a perftool-testsuite and
> > > incorporates the review feedback that was previously discussed.
> > > A new patch (7/7) was added to fix the incorrect relative path for lo=
cating stderr-whitelist.txt
> > > in report tests.
> > >
> > > Thanks,
> > > Jakub
> > >
> > > Link to v4: https://lore.kernel.org/linux-perf-users/20250930160923.1=
3728-1-jbrnak@redhat.com/#t
> > >
> > > Changes since v4:
> > > Patch 1: applied review feedback, renamed shell_info -> shell_test_in=
fo, minor cleanups
> > > Patch 2: renamed shell_info -> shell_test_info
> > > Patch 4: renamed shell_info -> shell_test_info
> > > Patch 7: added in v5, fix for relative path to
> > > stderr-whitelist.txt in report tests
> > >
> > > Jakub Brnak (7):
> > >   perf tests: Create a structure for shell tests
> > >   perf test: Provide setup for the shell test suite
> > >   perftool-testsuite: Add empty setup for base_probe
> > >   perf test: Introduce storing logs for shell tests
> > >   perf test: Format log directories for shell tests
> > >   perf test: Remove perftool drivers
> > >   perf test: Fix relative path for 'stderr-whitelist.txt'
> > >
> > >  tools/perf/tests/builtin-test.c               | 129 +++++++-
> > >  tools/perf/tests/shell/base_probe/setup.sh    |  13 +
> > >  .../tests/shell/base_report/test_basic.sh     |   6 +-
> > >  .../tests/shell/perftool-testsuite_probe.sh   |  24 --
> > >  .../tests/shell/perftool-testsuite_report.sh  |  23 --
> > >  tools/perf/tests/tests-scripts.c              | 288 +++++++++++++++-=
--
> > >  tools/perf/tests/tests-scripts.h              |  15 +
> > >  tools/perf/tests/tests.h                      |   8 +-
> > >  8 files changed, 398 insertions(+), 108 deletions(-)
> > >  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
> > >  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.s=
h
> > >  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.=
sh
> > >
> > > --
> > > 2.51.1
> > >
> > >
