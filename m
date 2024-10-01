Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C71C9B7C
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790700; cv=none; b=LqyS43O9Vlk+7GCbf+0YpaiYrRx4P2cGuinKnMVdQ70e37s3+DiB3JtRkOsdgO7AJitI/XRQ3x/O2QMIW+tQznTysFQLoE5Q1Bc50bO0fyArLXEw1w205ayBUQy19fCifStS0CpZku8azV+CP0S6OPRWJQy0A0GsJ8cgjx1gfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790700; c=relaxed/simple;
	bh=DKMT61YzqQ1gvISKlWmlLIYiprIGfEGiqyn8K0KQMmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCvUyWnP+6x6TflIQ/XEmWWhhbFrke0Js0ZcYEDx5XKiTemS2jGJL7BAmdxIBm6a8jZuDaVEHaAoR2RxBbco9B/12/2IDWfT0wt0JUz8lNen6e6Q1GqI+foJXym7XrBwdLgGiH4LIv7FLyg2hr59WsUhaVkPDy9NfzI1yOlyreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbeWAO54; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbeWAO54"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so188645ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727790697; x=1728395497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48wUOkFe53TjLWfnqR6mtcm302S1oICUhkJf6xdI3GE=;
        b=bbeWAO54ycOWxO4QS37HsMCVVP+9lAT3kT/fCSUbiN1Cc7nslyZzuWlg8RrEVfCYWz
         AAe60SxpsbgxeHDcjcZ0Uuy8qh1yRQOVCr+Ma9yu7dhs3hEOWsiSDSbd5OMBEhaaRp4z
         ednp51iRYY+FkAr92AGVBmQceDoLbBqt1wdfv7IpIGXkmNV85/elKxhScNP4vKoBLUBc
         YgUYjOMXwAf5IymTqKrw4lBUJAZejMbRLi1pXYABQGVC9ngC5Wr/AhTC+n+nYIW1XLS8
         fOeQkYFdI4EtPmW5y5HRlrGwZq6QyJRelyxvUX9NFWIVTfid2VRIfRvjnTN5Nvba8s25
         4LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790697; x=1728395497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48wUOkFe53TjLWfnqR6mtcm302S1oICUhkJf6xdI3GE=;
        b=V8R2Q4ufnUnaCp6ze5D7c5kJHwHlgjeuHdPdCbxL5WdgL6p7qZf5kVO/ddhQt67NdJ
         CnfegH/M8QOkkdJ2cxn/r+qA5M+9KiBnLxV+045nURJpMUukKvAzdjRIStTO2YTNJlGj
         q6ApPD49oLCf5gfdGYtBq7OVXHXAzERuls9DpuycOTAIWpiMBEHgyCtHUatQdBVeKwx/
         yVL6ew7HnMQlPi109H8Zlo/RwDe+aNOnrYVYAKMDsqD/YHXQSv77SHBkIJZ8K8MxAfyw
         NhlRZUiMnY2XdxPOFFIlxi1SLrcwOCaBlbTLm60JqK9ruYHurqzTKHINlrzsY6k+Vl/7
         /t7g==
X-Forwarded-Encrypted: i=1; AJvYcCVFeWKO4CQ04KMQh49j83QL2OnGImVXCH72SIMFY6vc9QkkMdJjumPHMYWh1ICp0Mr+5uPvYKgOXKdYyrhHyBUB@vger.kernel.org
X-Gm-Message-State: AOJu0YxFh3Tj/r6eZNokXMmsrOOAhruQ7FveoIJRx46nEylnTT1dsKC4
	UVuez0bsKuXAQ885fMVdbnJEiO2ZW6/oC4ogFaodYxlQWBtljcaIzX7+We3aS9VjyMAwbzIiVpK
	Lun4iws5a9OYDzhg0SFmxAtiLnNvPpuOWw2eW
X-Google-Smtp-Source: AGHT+IFcHk3nqjivw+SJYZ1aoJmxEgVk8y9/J6HHuCIHNMPZ7sipZFKYUdJWncidCw3XXnrEA8ibHKSYEC3fjQvG8T0=
X-Received: by 2002:a05:6e02:1a62:b0:3a0:b0dc:ac0d with SMTP id
 e9e14a558f8ab-3a36083bf05mr3161285ab.27.1727790696651; Tue, 01 Oct 2024
 06:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001123625.1063153-1-james.clark@linaro.org> <Zvv9eBDrquBHBHhF@x1>
In-Reply-To: <Zvv9eBDrquBHBHhF@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 06:51:24 -0700
Message-ID: <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Oct 01, 2024 at 01:36:25PM +0100, James Clark wrote:
> > The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
> > which gets picked up in a lot of places. Without
> > HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
> > errno.h to fix the following build error:
> >
> >   In file included from util/disasm.h:8,
> >                  from util/annotate.h:16,
> >                  from builtin-top.c:23:
> >   util/dwarf-aux.h: In function 'die_get_var_range':
> >   util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in th=
is function)
> >     183 |  return -ENOTSUP;
> >         |          ^~~~~~~
> >
> > Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback f=
unction to handle arch specific instruction tracking")
> > Signed-off-by: James Clark <james.clark@linaro.org>

There are a few variants of this same patch flying around:
https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.c=
om/
https://lore.kernel.org/lkml/20240924003720.617258-4-irogers@google.com/
Just a heads up that we only need to apply 1.

Thanks,
Ian

> > ---
> >  tools/perf/util/dwarf-aux.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> > index 336a3a183a78..bd7505812569 100644
> > --- a/tools/perf/util/dwarf-aux.h
> > +++ b/tools/perf/util/dwarf-aux.h
> > @@ -9,6 +9,7 @@
> >  #include <elfutils/libdw.h>
> >  #include <elfutils/libdwfl.h>
> >  #include <elfutils/version.h>
> > +#include <errno.h>
>
> Simple enough, thanks, applied to perf-tools/perf-tools.
>
> - Arnaldo
>
> >  struct strbuf;
> >
> > --
> > 2.34.1
> >
