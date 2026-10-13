Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB043233954
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932956; cv=pass; b=X5Nu93IDtsDVVFqe2IKSoD0UuwD3UJS65T4UMePSmWd512QD1tq6EU1MAtPdFSKcdkdAFgtJNje5/ZytGJi2ikuxCGiV6xY8gLMqQN4cC3rjxaRbf7B1HLZnh2qDvkE2js1evmp5lQK20NsJFj3WqY+SNocNmSW21TcS8+8o+I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932956; c=relaxed/simple;
	bh=JvtBTH42uQf0GJZrDLEFCb32oOnKW32kHQ1fPumsBNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nH3m+PhW8b8H8+emX9TOwlu0DEQduD97DUDvtVsgPc+Dt0RnuQ+Q4+VVBpewOoyrsmp+AfcrdsWbTR8y9DK7XLcHAx0nq/dlDaNUyaIx5yzwtOg4IFvsW7lJfkNKFCI8z3gXad3KB1MeAl1nUgiEZxJ1yy50uyW76LCtLMR7Df4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvZ2oxda; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvZ2oxda"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so965571cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 16:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932953; cv=none;
        d=google.com; s=arc-20260327;
        b=EosrvW/R6FQTnkf3dChPwVLj1oHPZ9hdXHm6hUn1MczCiE2K4L8IW2BKcCdY6B/ggC
         01Mn1ucXAklFmZznTGYoyUemiNDWQ8U8e6EB0fauBP10V3UWlgjaBaSiukvWwM+LZeYU
         P/GrLBk+TA5qgbXaKXVW7Ep5hdIqcBO6ED/29f0xMcNq2DW0cYBVqoQ8TN5Civai8yKl
         lyjri1E+a4n5wnZWFHgEh5Hr9tEVVATu+1KDFlpwBuQG2UsdcWSP5NQqs21CgF0/99gL
         t8JsZVes7xg2p7/wGSWrAAAGioPLqMR6C5noyZU8zDuSiQBBEHNIJp6v4UjBBx6UtUCs
         iNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKJEP+nzVcv1V56tS7nuXBPb/u2Yy0nrN8gT7QG5wn4=;
        fh=H+ZhecqzP3b4/Z2Yej0oy71jKPyQd6oOgc4+Kwl3hFI=;
        b=RHZc/7IFzX4jsn+HDu67PU7t6umN+fo0rjPQZ3nlbIrhqqHGDa9ZHfDbCnYoPEeGPr
         d3wYsErmRLbthvQOTMDmh33mD/DBhNcIjOAaOn9kOKXkJ7wOlcOXa36w/jXzXOqjvu8Q
         4aqYLMvuvDLIqVJmQZZxiwVT7Cu8zB98D2OwtNU4PuV6Iyaeu/NM4FTjonLQ6hvE6Ixp
         jdXo4+F+FXgJmz/3yHnWcosoiORBn7oaYz4a++Ri6WLUUxllT3pcIobh75sNwi86pZXM
         u4Q+sldGMmqYuA6sIg7GOObvCfVe7TaMjvs0hg2PzKrR7DN51GJ4RZZ6W/IAr9R+/zPt
         6SsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791932953; x=1792537753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKJEP+nzVcv1V56tS7nuXBPb/u2Yy0nrN8gT7QG5wn4=;
        b=HvZ2oxda1y1mNTUN/qytYfPE0tCnzqF2k/B7MypsxH5msVTi9L4yiMrnf9IizmVGCG
         SXIIHjSmKqUzUYlBdw0TVXnavW59xGvPyXz7CFX+S8R0y/GgXZShPHaQWmhap9jzBtz2
         kKP2DQk8zMHXot3TncoLHjlrMa31w7wWM+RZGFR2xTs9MotOIFI104YgvJZIvrGUbKHz
         ZMJeAg/BYupGDDmdDwe1OOkObWet0CHI2ZkUpGKHLCDf9X0f+wJlq0F5oGsPKIKO0rob
         YACMH1R9T/0+47dU5iEeefzHLcnFuYZwErUcX93N/HbdxE7649L5Uj9oDKeww70dJsiC
         WXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932953; x=1792537753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKJEP+nzVcv1V56tS7nuXBPb/u2Yy0nrN8gT7QG5wn4=;
        b=KY+07xE5PPByd730S1YZNz+o9eUCODtLYcn8xlgQ8zb874FP2YViDV8TG7V1hBqRgf
         pH5KHLCPBB8Q7PhiqEg6UbyRqtYKwql16NYEf+81aRHiOz2ajsl+lBJyCQwejCVvKaFF
         OfQlIDO5JTAMjvit65svy7LBkkhE+C7WZRNc45BUtKNEZG6Bm0EhLzO04FE0c7AnPMlo
         k45xlPi/KGnZHsu70UG+p31JLkI+1zsMU4Mz6MfOhbYhWl9j/0Vl0HBk6+6mNo2X1y5x
         gqTk4t8Qejykl5YXvP4MMjYCHZcmKkn7y5mDyXbQs2t5X5DyaG6LVQ6PAFTIGngNGnyZ
         rmqg==
X-Forwarded-Encrypted: i=1; AKwUvByS0xNLwWamlY84EhKPKOv4YX7zmehMVbvC72gi6iZRytMWachGKpld7AFPvi5uvxygpLZS5q9Mwc8IDgwem45I@vger.kernel.org
X-Gm-Message-State: AFq9FYJMkIvgzD3+OtihBqVIZB12Se8FBeo/WV4pKCa0BUMyy+x3Kea8
	9bbWVp9Ub//IbC2Q+8DF+/+aECswGC9iMKYvz+0VleA1YbQo3qXZtOmB2pyhrj9JYyayxpFtKHB
	EWgYcWDddcbJAddwdKmyXxUsZT4gGfrK5APCT8CN/
X-Gm-Gg: AYBFou1i/tFSWCI1PFdRugHR8snRKnWbF7VKdUyx6GL0yH8I9fgpkrfWgK/t8jLbRXe
	SHC97CVEjc7sgE/eR33+8L0Nk9SMm1JVXUsty7xzz5wogyNw15ya2UsaizSyL9z8RX7GR22X6dI
	afpzj+bIM87jkRSXSWMszdayWFqWtmtsZmQOtGLQE3/ftNSK/Y/WxZBn9v7+n6YIIEMKNgfy/Of
	W142PN8bmB7WRuxI4B+mRJ1hh5n9MvoHtoiVwBG1nTFT2j8A4oXkxkGMuoxDNQQ+OYq/cHe124H
	iaL89UANdVvuFexel5ND5oEqiG6ovlvTX3PmQTHmoX+GDiDM8S9suypFuErlOm4EXFB2RKTl+gV
	WMcfJ+9eT
X-Received: by 2002:a05:622a:2b48:b0:532:d36c:7094 with SMTP id
 d75a77b69052e-53602cf1301mr1528801cf.4.1791932952857; Tue, 13 Oct 2026
 16:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
 <3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org>
In-Reply-To: <3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 16:09:00 -0700
X-Gm-Features: AclHuK8sVKLuenhmPgQR2YkD4GWpk6lsXR7zsTAaKiowHqlv9ljvmiPS-1EbOyM
Message-ID: <CAP-5=fX3e4HRaLXxQhCwEHRuXZdpC0zEEh2pozEEegQBxgc5xw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
To: Bart Van Assche <bvanassche@acm.org>
Cc: acme@kernel.org, elver@google.com, namhyung@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:53=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/13/26 3:26 PM, Ian Rogers wrote:
> > The perf tool previously added Clang thread-safety annotations in
> > tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
> > UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
> > unified set of static context analysis macros and attributes in
> > include/linux/compiler-context-analysis.h (context_lock_struct,
> > __guarded_by, __acquires, __releases, __must_hold, etc.).
>
> New versions of a patch series should be posted as a new e-mail thread
> instead of as a reply to an existing email thread. Additionally, posting
> a new version of a patch series only four hours after the previous
> version is way too soon.
>
> The LLM that I asked to take a look at this patch series came up with
> the feedback below. Please take a look at this feedback.

Hi Bart,

Which mailing list is objecting to the frequent emails? I'll remove it
and yourself from follow ups as the intended recipients are on
linux-perf-users except for patch 1, which fixes a build issue in a
file copied into the tools directory. The LLM feedback included was
flawed and introduces feature creep.

Thanks,
Ian

> Thanks,
>
> Bart.
>
> -------------------------------------------------------------------------=
-
>
> Verdict: Needs Substantive Revision
>
> While the overall goal and majority of the annotations are
> well-executed, several patches bundle distinct bug fixes with
> refactoring and annotation churn (violating the "one logical change per
> patch" rule).
> Additionally, there are concurrency and lifetime subtleties in the newly
> introduced dsos__findnew_id() read-lock fast path and vdso.c, an
> unsynchronized benign data race in maps.c, and missing Fixes:
> attribution tags.
>
> 2. Critical & Concurrency Findings
>
> A. Patch 07/10: Lock drop-and-reacquire race and unneeded
> re-invalidations in dsos__findnew_id()
>
> In tools/perf/util/dsos.c:
>
> struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const
> struct dso_id *id)
> {
>         struct dso *dso;
>         down_read(&dsos->lock);
>         dso =3D __dsos__find_id(dsos, name, id, false, /*write_locked=3D*=
/false);
>         if (dso && !dso__needs_improve_id(dso, id)) {
>                 up_read(&dsos->lock);
>                 return dso;
>         }
>         up_read(&dsos->lock);
>         down_write(&dsos->lock);
>         if (dso)
>                 __dso__improve_id(dso, id);
>         else
>                 dso =3D __dsos__findnew_id(dsos, name, id);
>         up_write(&dsos->lock);
>         return dso;
> }
> Issue: If dso is found under down_read but needs ID improvement
> (dso__needs_improve_id(dso, id) =3D=3D true), up_read() releases the lock=
.
> Before down_write() is acquired, another thread may have acquired
> down_write() and already improved the DSO's ID with the identical or
> better info.
> Consequence: When down_write() is acquired, __dso__improve_id(dso, id)
> is executed unconditionally without re-checking dso__needs_improve_id().
> While updating fields is mostly idempotent, __dso__improve_id() sets
> dsos->sorted =3D false;, unnecessarily degrading subsequent read lookups
> to qsort().
> Fix: Re-check dso__needs_improve_id(dso, id) under down_write(). If no
> improvement is needed, avoid calling __dso__improve_id().
> B. Patch 07/10: Unnecessary lock churn and array sort invalidation in vds=
o.c
>
> In tools/perf/util/vdso.c:
>
> static struct dso *__machine__addnew_vdso(struct machine *machine, const
> char *short_name, const char *long_name)
> {
>         struct dso *dso;
>         dso =3D dso__new(short_name);
>         if (dso !=3D NULL) {
>                 dsos__add(&machine->dsos, dso);
>                 dso__set_long_name(dso, long_name, false);
>         }
> Issue: Calling dsos__add() followed by dso__set_long_name() causes two
> separate down_write(&machine->dsos.lock) acquisitions in immediate
> succession. Worse, dsos__add() inserts the DSO into the array ordered by
> its current short_name. Immediately afterwards, dso__set_long_name()
> mutates the name and explicitly sets dsos->sorted =3D false; (lines 1528
> in dso.c).
> Fix: Set the long name before adding the DSO to dsos (matching the
> pattern used in dsos__findnew_module_dso() in util/dsos.c):
>
>         dso =3D dso__new(short_name);
>         if (dso !=3D NULL) {
>                 dso__set_long_name(dso, long_name, false);
>                 dsos__add(&machine->dsos, dso);
>         }
>
> This requires only a single write lock acquisition in dsos__add() and
> keeps dsos->sorted =3D true.
>
> C. Patch 10/10: Unsynchronized concurrent write in maps__find_by_name()
>
> In tools/perf/util/maps.c:
>
> struct map *maps__find_by_name(struct maps *maps, const char *name)
> {
> ...
>         while (!done) {
>                 down_read(maps__lock(maps));
> ...
>                 /* Second search sorted array. */
>                 if (!done && maps__maps_by_name_sorted(maps)) {
>                         struct map **mapp =3D
>                                 bsearch(name, maps__maps_by_name(maps), _=
_maps__nr_maps(maps),
>                                         sizeof(*mapp), map__strcmp_name);
>                         if (mapp) {
>                                 result =3D map__get(*mapp);
>                                 i =3D mapp - maps__maps_by_name(maps);
>                                 RC_CHK_ACCESS(maps)->last_search_by_name_=
idx =3D i;
>                         }
>                         done =3D true;
>                 }
>                 up_read(maps__lock(maps));
> Issue: last_search_by_name_idx is written while holding only
> down_read(maps__lock(maps)). Because multiple reader threads execute
> maps__find_by_name() concurrently, this is a concurrent write race
> (which is why last_search_by_name_idx could not be annotated with
> __guarded_by(&lock)).
> Consequence: Under TSAN or strict memory models, unsynchronized
> conflicting writes cause data races.
> Suggestion: Use WRITE_ONCE()/data_race() on the assignment, or annotate
> last_search_by_name_idx with a brief comment explaining that this is an
> intentional, benign unlocked cache update.
>
> 3. Patch Architecture & Organization Findings
>
> Per Documentation/process/submitting-patches.rst ("Separate each logical
> change into a separate patch"):
>
> Patch 07/10 mixes 4 distinct logical changes:
>
> Bug fix: Fixing the unlocked __dsos__add() call in __machine__addnew_vdso=
().
> Performance optimization: Adding the read-lock fast path in
> dsos__findnew_id().
> Refactoring: Replacing _dso__data_open_lock and pthread_once with
> DEFINE_MUTEX(dso__data_open_lock).
> Annotations: Adding static context analysis macros across dso.c, dso.h,
> dsos.c, dsos.h.
> Recommendation: Split this patch into at least 3 patches:
> Standalone bug fix for vdso.c with a Fixes: tag (see metadata below).
> Standalone performance optimization for dsos__findnew_id().
> DSO/DSOs lock annotations and mutex cleanup.
>
> Patch 09/10 bundles three disparate subsystems plus a bug fix:
>
> Combines perf config, intel-tpebs, and perf_env.
> Includes a real bug fix: fixing an unlocked read of tpebs_reader_thread
> after releasing tpebs_mtx in tpebs_stop().
> Recommendation: Split the intel-tpebs race fix into its own commit with
> a Fixes: tag. Split the remaining annotations into separate commits per
> subsystem (perf config, perf intel-tpebs, and perf env).
>
>
>
