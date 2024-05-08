Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5A399
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129485; cv=none; b=mEjA2XR+RK2Lke9hHFo5bFDQ5T3YBuQwv1cSktZK7YEeQfNuj4sTgVKyH0rWO4eNgSjQpinpmYunfXjMtFOI+FgCGsZGpcDMG1rNwi2t6mwQHJP+6h1j2gdqnEmf2lNAxJ7ybgU2n7gWcf3uf6TbYguOJeX5u0Rfubm6AGeocBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129485; c=relaxed/simple;
	bh=J9f+ozTQRVvFEaj/RTq9sBDGm3e0WJAgiC7XQw+Bzo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izmURtbytNNtKylgx0y6IOq3npX17XXOv33VUcT1SFHSTSBsgGvOWOeQS+xYzakWa1O/CorUx6wc75bLwd93Da9NI4kCtXpxHT693cFSL+WSEhgyUvZo0IdK5sn5kei4sNSjozYIKvRsUXkqquESzt5EQekKm6BfjtbRd86jd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShBxnWHS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShBxnWHS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so130121cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715129482; x=1715734282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yxY1w9XvCxUPvXqMAMhe9NTxvR+eY9pH/XL6Sd2kTk=;
        b=ShBxnWHSbUv0gI4AcmlLXXju+PAA041ExSciSa8xn9uJ1pMt9EuE8UlQVyX1xU4D5i
         JA4Y9bDVQKxtFfjtoguyElXBanujAyJ0uVAF6i4bkq+Kutr7dAt958q+Z7zclzNtJIUS
         bvNGOV9PvGNd4wJAyUcrrsPIYPNeuzbVKiE72RpAeew3n2hDmrbOoQ/ADYsWjU7TyrpL
         H1q0/lyTTglP+VdSqgzMtlHIh7D/l4TSBXzBhFytCFOZJ1sbnyX7E8AJAoErm/DDrCRc
         mLf1772L4paGcCaTFsWcMuLG209OtevIBcmyqdFA4Bcr9k618LOfw65Y5HqdMh9d+ALP
         nz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715129482; x=1715734282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yxY1w9XvCxUPvXqMAMhe9NTxvR+eY9pH/XL6Sd2kTk=;
        b=PTei+itDTICC5ZWX8QAQIf2+sI+vvasHJIz2VSea5UnHzTYgJZfJHxP5Oj5vE2XG5H
         nIQi5Dv15UGsCW/HU3fdjM7bExrOOmCtG6xEhGARFgtZXArgkdE6XA/No63AyWh8SH7z
         vj4TaZx9Nd+y/VydmNkf6B/XPANCsC7lCWxHt8nITgvhD4NrXBEovvIbAyrR/oRHhOFn
         UBeFwkJXJaaTDvPlOL2R4TjOIUSky0B6HGtwn80/324TIWena2/ss1YG2pfxOxE9Tb+B
         wKnRg3lhWICAUBfBSCQ9hopCJsMWPhvoUIDgeznBuYpoaZegYtV46Fd+er9utfO3QE/P
         0Ekg==
X-Forwarded-Encrypted: i=1; AJvYcCUfarKd9+tLlSXalEAt3mkY/Afm2jY3F7tRgN8bPo+lM2VJARlb1iuXXmZ3VOadWJiUMWsNvwGOuzzoxvXzwxHy7oHW6i9fdi5dzCsqEWJwKA==
X-Gm-Message-State: AOJu0Ywt/pTL7WxMUUgtIfm6F6xT0v2gc3+oYJ/h1EgYBTDfXJuBDXby
	z9Enx2TebYI+DhvmpyunJgBiej457o0Oiud7y4qt6rKE51AIbW3svfe9kPdNw86kjugxTRbTL4o
	TkZPPRBanNwpK03pcum/VJPKK15nSLAHFtp26
X-Google-Smtp-Source: AGHT+IG/cDhocQ0+FppCnl9oKclXai6sCmFa5FJbky5InQn/IU58BxdGTkJqtIyS4tha1kcPXsFT1AJn7wIJoBMOs8Y=
X-Received: by 2002:a05:622a:5490:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43dc2d9577amr1413111cf.10.1715129481777; Tue, 07 May 2024
 17:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com> <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1> <ZjqNjrJ2ElrT11iB@x1> <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
 <ZjqXa25BnFncJmw-@x1> <ZjqYD-q7EqQW6hVE@x1>
In-Reply-To: <ZjqYD-q7EqQW6hVE@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 May 2024 17:51:10 -0700
Message-ID: <CAP-5=fVRBXv0H3vRNYO_uwWsNGvBxWVXd78UOu0QvGK04+bERw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack memory
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, James Clark <james.clark@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, May 07, 2024 at 06:04:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 07, 2024 at 01:48:28PM -0700, Ian Rogers wrote:
> > > On Tue, May 7, 2024 at 1:22=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > > > > > ui_browser__show is capturing the input title that is stack all=
ocated
> > > > > > memory in hist_browser__run. Avoid a use after return by strdup=
-ing
> > > > > > the string.
> > > > >
> > > > > But everything happens in that context, i.e. hist_brower__run() w=
ill
> > > > > call ui_browser__ methods and then exit.
> > > > >
> > > > > We end up having browser->title pointing to returned stack memory
> > > > > (invalid) but there will be no references to it, no?
> > > > >
> > > > > If we return to hist_browser__run() we then call ui_browser__show
> > > > > passing a new title, for "live" stack memory, rinse repeat. Or ha=
ve you
> > > > > noticed an actual use-after-"free"?
> > > >
> > > > And I'll take the patch, I'm just trying to figure it out if it fix=
ed a
> > > > real bug or if it just makes the code more future proof, i.e. to av=
oid
> > > > us adding code that actually uses invalid stack memory.
> > >
> > > My command line using tui is:
> > > $ sudo bash -c 'rm /tmp/asan.log*; export
> > > ASAN_OPTIONS=3D"log_path=3D/tmp/asan.log"; /tmp/perf/perf mem record =
-a
> > > sleep 1; /tmp/perf/perf mem report'
> > > I then go to the perf annotate view and quit. This triggers the asan
> > > error (from the log file):
> > > ```
> >
> > Thanks, it is indeed a bug, I'll keep that Fixes tag, people interested
> > in the full details can hopefully find this message going from the Link=
:
> > tag.
>
> Nah, I added your explanation to the cset log message.


Okay, I found I needed this to avoid a segv introduced by this patch:
```
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index c4cdf2ea69b7..19503e838738 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct
ui_browser *browser)
void ui_browser__handle_resize(struct ui_browser *browser)
{
       ui__refresh_dimensions(false);
-       ui_browser__show(browser, browser->title, ui_helpline__current);
+       ui_browser__show(browser, browser->title ?: "", ui_helpline__curren=
t);
       ui_browser__refresh(browser);
}
```
I also found a use-after-free issue with patch 5. I'll send a v2.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
