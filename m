Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5A2DAFD7
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659520; cv=pass; b=T40U9LnJ5jZdTHFXa0HarRbomSIJk0Ojycr7YymaPJSkSizBDgiJOD4WcOyav/MeNr2ifjhwXRdOAAcmtv1KJIlA1+I3IHCA0ZXd4+WHh8zT4h98TPUtEjK+ENpI54zFQ9Jf/QapfZwOplYV5oXNa68Yn1ZbXrJwdB9jPCk6sIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659520; c=relaxed/simple;
	bh=otcerN75AZSL31zIS6eCDG+YjBFptzGBhku9/e9Nu4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQGxJhk+Zo6d2qvJWypmfmzE5dPhotBRNqu4wbLwkG7BP9U2IozIa5NfAr+vCDraYLM8q4jhz4QfxB7SuIaU1zqXid/jLJ2GEQLwrF/9g2EYp1SP0CgW3nh64u+JPzm6czd3ntUAliiPd+vEhHBKSrPK3k8WRhWI/c4PtMXofGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ei4cMowV; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ei4cMowV"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8cc7a77eso2354460c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 11:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659518; cv=none;
        d=google.com; s=arc-20240605;
        b=TOklLlGCvFU8iGQqP7CyBvbb7BSBh/xYqouh8x9lsXZv45veiLdPmPTE+NjFLHbNxW
         ST7KBse/A/6htUbl00ywBVklZCMqy/kDbCo5alnSjevwSWX5Gt337oKa6bS9GQLUkGPE
         hNxD85IgZHc+/7RPoCuG9J8ppiye62zmv5iegqA7oUYg3URM0W/i7coIdrttnjLLpld+
         ctKJWTBRK78RwCSa2azOQU8AZmAROqX6pySg+sicjCES2N0XhHQRVqPoQoCOclB4Rl7C
         NN+ZprOQGK3fYCe6caHKSH+rWPOwxrmQIvi0iXJfbt9L/CBoxncpk2gawf+zm5TGKqr/
         cwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cMzDnbJ5LokBfUy62Owj7gNisOlIbdu38S2Z0nuYGhQ=;
        fh=ecEyErCoczAVeRt+pJcFSbx/Yu8OK/+YhBOECT17vnc=;
        b=QN2utD7Qk6WX3tAT0KWuhJqXIUU2Cd521bflG050dK3EbNsUCit0PItDgiHUFIPCrA
         VDj0yXU/FAKCjRNc2jyJOU9vouEdKJORrt39zo3NGrw5M8jvgWyMq2GGA1EXA1RLqAD4
         Wf6Deh/h3zU0XSO6sAbjirIhlE1SV7GeWd7GfXl7jfIqywLea+7ri2jq2bVybWSULCCh
         N5EDSZKCzTh3P4pre7Ze6nLo5sARTxDgZyLSq/1W0S1GpkDKX8b4dauoxtyaNALUo54h
         TOis5hdWN0t2kJJXPJNkNAfjPWSlkDiExTBRkyqU4gxEzxxZQZqN4NL9gNfhhy9cWr0v
         mFlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659518; x=1778264318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMzDnbJ5LokBfUy62Owj7gNisOlIbdu38S2Z0nuYGhQ=;
        b=Ei4cMowV4BBuuiU/+X2onNjTA6YISsapud3XWvgB+58MJ3HVOTQ8c1w8I1lBlYkVFh
         rKNCS6qEAc610g9V30vAhJdz4HQnA8sUWqQekuqZBuYmLbeXrwLzzlTvMxjjvAyZD1Df
         +mAK2OFhaFQkhkhb3xK5hp3NYox9P/ImvZtOzjjJGT+vnyAqb6tknd+W1JWyucbDNtNi
         0D86HEUb7LvFUy4f/ffz131MmARrkwSgdfvTngHgWxhiWjKjVi1j/awTizHUpkzLNGBj
         4/6sJGWL6IWTFvXDHAz6xEb5+JV2cRA/TsmQPSlw4bxfRR80PfkN1Kv+ER5ZgAKboBMw
         jlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659518; x=1778264318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cMzDnbJ5LokBfUy62Owj7gNisOlIbdu38S2Z0nuYGhQ=;
        b=SNYgJfgbrZtWhxVFqXemVJmtn1i6V0bCuxLjZtJvdIEiGbVR2DL7GYhCEqMXSzFRv6
         GSnC/xmyZAyvoDU287MsclObcXeeutnQIRNrlqPeng9PEwdv9wVmxz4SCXgW7t54jEBn
         6emj8ZF3+ZXdVRbiGEMC8Tya6mVQkHPe/ZvpMy1Y6zU78L6zxFzfbYio5hR1i8CpxE6A
         dmE4Srz4ferNwj/7ae2gEe/gdnZTzs3712IsSVr8H+BMDgJgUMwYnhTc9iWmWM5dtzTB
         D2vyOWxF6uOi/Rz+H7868geVj/DjFRTi9WrI8G3M0GYYgn6XJOtSLUO0BA+D7tt+7F6P
         KaFg==
X-Forwarded-Encrypted: i=1; AFNElJ+1XfutviyX+Fp5IplSI1LVrMlbuTePcKCQ5RITqOP/hVWAFH2p9YoS+aBY5ZcbaLhA7ZIZFJLWDLQZCgwrGoo2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ev6RGRdUvNTeiNf+71HS2RWlj/vSJ7AlozUzt3NbA7X8fh2F
	lFFKtHC33GIPVYrl0XtURihHEkwuz7A5UR06upne2iiSlFeWp3rDGuOxuuw+7o2XMbyI4Y6kfjh
	TjcWXnYSSqd4iW7HY5cNA+iRS2Vi5rj1kk/xzVgzU
X-Gm-Gg: AeBDiesYIJUmN17lrvQlbBFsrm+ehhqL1Ln1hxHphIurpnHpUr4TNCwxQTdIveSTM/f
	1cmdy29vcVEy2LDT/yBwMs4GwR2I+IhsEAsHMlfVbWtndqV7KBwk1hCHBsPYU0wu5FOKkx9ib1K
	NA+0zOviuk4C+bLa24v+FLnqwjBJfXGYQ/4lRKSxAskdJadiV1KTnqGZGVObflOfy9ltqogvPeQ
	BsQEXpdUkA4kQEjUHiiPXtdPsghz75ugANf7lZbV8peYdsu+CGZFRSsRxdt7zYOxYpleuhHCWDC
	MWsxTUMD+rL3iyalhGionbg6u7I=
X-Received: by 2002:a05:7022:e1e:b0:12d:31cb:b806 with SMTP id
 a92af1059eb24-12decf3d924mr3663574c88.26.1777659517471; Fri, 01 May 2026
 11:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416204828.1303734-1-ctshao@google.com> <CAP-5=fUa9btU_FqtTUH02+CRmVgkudbQ+SA-J=pmNhf0zgq8Rw@mail.gmail.com>
 <CAJpZYjUXkfCNwKdXR_z3PTz8UFwG2DJK+1Bq0X93sMtcU+tZEQ@mail.gmail.com>
In-Reply-To: <CAJpZYjUXkfCNwKdXR_z3PTz8UFwG2DJK+1Bq0X93sMtcU+tZEQ@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 May 2026 11:18:26 -0700
X-Gm-Features: AVHnY4JP8wAT6Ga4WM2M9nWwyerYRjycWjyDdB_4EgV3RBMfwVltYWgWSZv8ffs
Message-ID: <CAJpZYjVNv6WQz9tU-PemjEfomJxWFfRUFyYX7nM=1BMw6brzuQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Merge CPU maps when merging uncore aliases
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My fault, what I mean was "tweak should_skip_zero_counter"

On Fri, May 1, 2026 at 11:17=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Instead, I submitted another fix to tweak `Merge CPU maps when merging
> uncore aliases`. Please take a look
> lore.kernel.org/20260501181129.938256-1-ctshao@google.com
>
> Thanks,
> CT
>
>
> On Thu, Apr 16, 2026 at 2:05=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Apr 16, 2026 at 1:48=E2=80=AFPM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > Sockets with event zero counts are hidden in `perf stat --per-socket`
> > > because alias merging aggregates counts but not CPU maps. This causes
> > > the display logic to incorrectly skip sockets not present in the lead=
er
> > > instance's map.
> > >
> > > For example, with AMD_UMC:
> > >   $ cat /sys/bus/event_source/devices/amd_umc*/cpumask
> > >   0
> > >   ...
> > >   128
> > >   ...
> > >
> > >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0       12                  0      amd_umc/config=3D0xff/
> > >
> > >          1.000777829 seconds time elapsed
> > >
> > > Merge CPU maps in `evsel__merge_aggr_counters` to ensure the aggregat=
ed
> > > event correctly reflects all underlying PMU instances.
> > >
> > > After fix:
> > >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0       12                  0      amd_umc/config=3D0xff/
> > >   S1       12                  0      amd_umc/config=3D0xff/
> > >
> > >          1.000666681 seconds time elapsed
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > ---
> > >  tools/perf/util/stat.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > index 14d169e22e8f..d696d217f98d 100644
> > > --- a/tools/perf/util/stat.c
> > > +++ b/tools/perf/util/stat.c
> > > @@ -535,6 +535,12 @@ static int evsel__merge_aggr_counters(struct evs=
el *evsel, struct evsel *alias)
> > >                 aggr_counts_a->run +=3D aggr_counts_b->run;
> > >         }
> > >
> > > +       /*
> > > +        * Merge the CPU maps so that the display logic (e.g. should_=
skip_zero_counter)
> > > +        * knows this merged event covers all CPUs from both aliases.
> > > +        */
> > > +       perf_cpu_map__merge(&evsel->core.cpus, alias->core.cpus);
> > > +
> >
> > Once we have counts, mutating the cpumaps seems wrong; it could impact
> > other things such as the evlist copies of unioned together cpumaps.
> > I'm confused by the bug, we should have two aggregate ids one for each
> > socket. In should_skip_zero_counter it should only skip the zero count
> > if the counter is not applicable for the counter currently trying to
> > be printed. Does the display code fail to iterate through all the
> > counters?
> >
> > Thanks,
> > Ian
> >
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.54.0.rc1.555.g9c883467ad-goog
> > >
