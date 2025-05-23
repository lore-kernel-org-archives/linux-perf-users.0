Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C7293730
	for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015530; cv=none; b=Z3verGP85HU69gGLGHkHKGR3hZJKz3/pddRppqpfnr8NJAPyMmpASOQBC27u/WBwii1kBfhuv/8mk+nye+UdwmF4M6L5mcYOVrm7CwQrRwJYGQcIbqsj8SijDbVslK0xYzrz10KLqeuXREs5eQ1TTfQqdykgM7ishEDUYKXfbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015530; c=relaxed/simple;
	bh=6Ci2ffzHFklOZlPZ/8TLi4kYhpDoFdShZWx0phelz7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbVfM5W4T1Nn2wUCoy+CcvyLXxUMo/dRQsK3JW64i+cR5hdkZlB5QlzKAdPfwMJtekYExVejGsr16l2IXP6bOG825lhZhYc5I6Ec9dCiY5t/4bcDYEUPXlMlM2Xy31gkBvd5H624pJwQFj3sGHcZGCCsg5bKkylvBKX8Y8X1wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfhQ0rMF; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfhQ0rMF"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3db82534852so190155ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748015527; x=1748620327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtCV5IRM1zP4VKEPyGngJ45l352CV0c9r+ha/qRRcUo=;
        b=VfhQ0rMFWOZ0T/V2rS1bMiyrnWsRXiDiywigPWI3NJmVmEAqyyf1j/l7JcUvpYAEE3
         BWn6e4KfMDLnQI4WcmHbcHytuaQJS0tLlPCb4AkZvrZ+TC5zZNn2pbZdtQnk/LRKK0es
         PpBD80ghN7g+jHwxIyudxRmH2oC8n6EO4sJs4+UbRB7Uc2RVqO+XFtqSMrv/+EMEMKCW
         sPHB7/OzqkZ+rEe/tckQMnXBYXOe/KaPPcCIa0tVN+Z/eiaDKB7y1n1z+LJqlVt30hCi
         tgbezOd70jGrCkuPZFSWt7NTLSTnH4wTwfy0V6SjTlaBk1DniZ6obxj0R8cdWnu1DRuS
         USHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015527; x=1748620327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtCV5IRM1zP4VKEPyGngJ45l352CV0c9r+ha/qRRcUo=;
        b=SWATvXdo1aVP2dpLDYtQNJUhZQ7q+lj0CXHGtWYSZ1kZYZepCBh60gp+lGEdBr/dWY
         XoWO/UPXgjAsfn1pVO8Q+jzIQg/3Gb60DUSdHa7HZzlRyDSvvKysEXrvX6Bu71GCji3j
         IXz+svyqvBMH6Hs61ucL+K5+Ngxh4KTNhDYaHxEyFlj6CUixrbdW0mswKakwrOeCzvSC
         hYC7iV8WghQlrk5pgZn2DxuqFskkOEKyB11wwpcqocWPIT/seJUir2x6YhmJR3i2uRwI
         Kx5TU+ZuYS+9LDvpW5eIK76t8KuoVuS31+RjTlefoB3x/Ry6rcu3fvrYh7vW6x8c8Swm
         E7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW/niXuLjygtEnTspKfL/CsEUzxgJHgk7kVt308SSlNrYbl2y2HWhPLcZWf7E8c3k03d8oEwoSLgama4R7GQLTw@vger.kernel.org
X-Gm-Message-State: AOJu0YzsM8HrogwXBb59b+jqjEgbGsZ3Ot4TNe3sf28u1aWx3VEKGwLu
	5hB4tGW7tosyoe1dM6kxLJyk1J0AwL6HbVZCTD7014swpXzSh9TgxJOw4OncdU8JfGnHEbRpj1k
	aL+sjdwhwZxHdr4Sm8ACiARtkWy9AEzCOU/lSabdp
X-Gm-Gg: ASbGncugEh3uKtsPNnVtMRMC81ArojgQaWP/Rglim71VECHVeFdgvOwDkOasiAa78a0
	bHMSZPqcIXHPZ6/V1Ikr8lkQwDjrEsD1GqTgkVlajXJNJ6saI/unymDKdZdpjBunZSydpW9dW9D
	xbQq/fdAnMiJXImZtayB0ZfthM91NCFdK6UA34IB/aofGI
X-Google-Smtp-Source: AGHT+IGCx5IQO/aafjcEB4ZP4xKmAxJz98hnNoE1ekMPoEKLzWQ7g9JRRFUVegf2BwJ7/s4lyfp6bQASwE+H7sb/qzE=
X-Received: by 2002:a05:6e02:380d:b0:3d9:6498:ea24 with SMTP id
 e9e14a558f8ab-3dc93ed5824mr3166685ab.6.1748015527268; Fri, 23 May 2025
 08:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521135500.677508-1-irogers@google.com> <20250521135500.677508-4-irogers@google.com>
 <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com> <CAP-5=fX5q7rDgBdB+cMH6fTyHBBPyiac7tuv9WJOMcg9OFdq5g@mail.gmail.com>
 <9aa2c899-80e0-4626-acb7-5331fbf46a0d@linux.intel.com> <CAP-5=fW4brQZQ-tMDj+N9MnddRVZidi4L5uSw1mvv_9OD_vOSA@mail.gmail.com>
 <c56c9e23-cf6e-4040-aee8-da13d5157dcf@linux.intel.com>
In-Reply-To: <c56c9e23-cf6e-4040-aee8-da13d5157dcf@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 May 2025 08:51:55 -0700
X-Gm-Features: AX0GCFs20fnHOKGzIOxOvuqnljN_QalrV1pNnkFkYY7r4dSAXY3nZdwsaM0FlFM
Message-ID: <CAP-5=fWXgEMf7ZesTg6+JJ_nV1s1ZM4xPm2R1umXSYkM208ZmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf sort: Use perf_env to set arch sort keys and header
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:51=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2025-05-21 3:19 p.m., Ian Rogers wrote:
> > On Wed, May 21, 2025 at 11:14=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >> On 2025-05-21 12:16 p.m., Ian Rogers wrote:
> >>>>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >>>>> index 7b6cde87d2af..13ef0d188a96 100644
> >>>>> --- a/tools/perf/builtin-top.c
> >>>>> +++ b/tools/perf/builtin-top.c
> >>>>> @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
> >>>>>
> >>>>>       setup_browser(false);
> >>>>>
> >>>>> -     if (setup_sorting(top.evlist) < 0) {
> >>>>> +     top.session =3D perf_session__new(/*data=3D*/NULL, /*tool=3D*=
/NULL);
> >>>>> +     if (IS_ERR(top.session)) {
> >>>>> +             status =3D PTR_ERR(top.session);
> >>>>> +             top.session =3D NULL;
> >>>>> +             goto out_delete_evlist;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (setup_sorting(top.evlist, &top.session->header.env) < 0) =
{
> >>>> I doubt a valide env can be got in perf_session__new(), since there =
is
> >>>> no perf.data in perf top.
> >>>> Maybe just need to invoke the perf_env__raw_arch() instead to fill t=
he
> >>>> env->arch.
> >>> I think the current code is making things harder than it should be, w=
e
> >>> should work away from perf_env__arch and strings, instead using EM_
> >>> values which we can default to EM_HOST avoiding any runtime costs.
> >>> Looking at perf_env__arch:
> >>> ```
> >>> const char *perf_env__arch(struct perf_env *env)
> >>> {
> >>>         char *arch_name;
> >>>
> >>>         if (!env || !env->arch) { /* Assume local operation */
> >>>                 static struct utsname uts =3D { .machine[0] =3D '\0',=
 };
> >>>                 if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
> >>>                         return NULL;
> >>>                 arch_name =3D uts.machine;
> >>>         } else
> >>>                 arch_name =3D env->arch;
> >>>
> >>>         return normalize_arch(arch_name);
> >>> }
> >>> ```
> >>> in this case env->arch =3D=3D NULL and so the uname machine will be u=
sed.
> >>> For perf_env__raw_arch the behavior is similar but it populates the
> >>> env:
> >>> ```
> >>> static int perf_env__read_arch(struct perf_env *env)
> >>> {
> >>>         struct utsname uts;
> >>>
> >>>         if (env->arch)
> >>>                 return 0;
> >>>
> >>>         if (!uname(&uts))
> >>>                 env->arch =3D strdup(uts.machine);
> >>>
> >>>         return env->arch ? 0 : -ENOMEM;
> >>> }
> >>>
> >>> const char *perf_env__raw_arch(struct perf_env *env)
> >>> {
> >>>         return env && !perf_env__read_arch(env) ? env->arch : "unknow=
n";
> >>> }
> >>> ```
> >>> Aside from caching the arch, the main difference is that
> >>> normalize_arch isn't called. Not having normalize_arch means the code
> >>> in arch_support_sort_key and arch_perf_header_entry would need to
> >>> handle strings "ppc" as well as "powerpc", "i386" as well as "x86",
> >>> etc. As I'd prefer not handle all those cases I think the way the cod=
e
> >>> is is best given how the env code is currently structured.
> >>
> >> Right. The perf_env__raw_arch() doesn't improve anything.
> >> But I still don't like &top.session->header.env.
> >> Because I don't think you can get any useful information from
> >> top.session->header.env. It just brings confusions. (It seems an env i=
s
> >> retrieved, but it is actually not.)
> >
> > Well there's a certain consistency in using the session env to set up
> > the sorting, etc. This pre-exists this change with nearly every
> > builtin-* file doing `symbol__init(&session->header.env);`. perf top
> > does `symbol__init(NULL);`:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1811
> > but the code now has lazy initialization patterns and handling NULL as
> > a special case of meaning host machine:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/symbol.c?h=3Dperf-tools-next#n2350
> >
> >> In the perf top, &perf_env is used for the existing cases. If any env
> >> fields are not available, perf_env__read_XXX() is invoked to get the
> >> information.
> >> I think we may follow the existing usage, e.g.,
> >> setup_sorting(top.evlist, &perf_env).
> >
> > So using the global perf_env rather than NULL feels preferable but I
> > think the global perf_env should be deleted. Whenever I see the global
> > perf_env in use I think the code has a bug as the perf_env should be
> > coming from the session or the machine. The global perf_env can have
> > no meaning for cases like `perf diff` where more than one
> > file/header/env is open at a time. The global perf_env variable's
> > existence encourages bad or broken code, so deleting it should avoid
> > errors in code. Another place these issues can occur is with TPEBS
> > where we're maintaining multiple sessions for sampling alongside
> > counting.
> >
> >> Alternatively, it looks like the perf top doesn't support --weight. Th=
e
> >> env->arch should never be used. If so, a NULL can be used as well, E.g=
.,
> >> setup_sorting(top.evlist, NULL).
> >
> > So I don't like NULL because then we have lazy initialization of host
> > data and NULL meaning use host. I don't like the global perf_env
> > variable as it has a code smell about it. I think moving the session
> > initialization earlier in perf top so its env, although unpopulated,
> > can be used is consistent with `perf report` - this is consistent with
> > `perf top` being `perf record` glued together with `perf report`. So I
> > think the change here is the smallest and most sensible.
> >
> > Longer term let's delete the global perf_env variable,  perf_env__arch
> > should be switched to a perf_env__e_machine as then we can avoid uname
> > calls just to determine the machine architecture, etc.
> >
>
> I'm fine with the session's env, as long as there is a consistent env
> source in the perf top. Because in the recent perf top fixes, we
> randomly pick the env source. Thomas's patch used the global env, but
> this one chose the session's env. It brings confusions.
> https://lore.kernel.org/lkml/20250513231813.13846-2-thomas.falcon@intel.c=
om/
>
> Could you please send a clean up patch to address the inconsistency?

Will do, thanks Kan!

Ian
