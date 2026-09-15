Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596040F743
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512666; cv=pass; b=twhwC+RVeeRFufeAYsToL4ZGu/OQ2iwxgs6VnYjkbFcPCUGPk3PF/Uf5BFkUwoOWKKskK7cvWKWLJLu4eAU8qH3xKdL8OJ3O8Ay490a8JGNPUlwFNUTvdX+gT4ChFhqlSCbcI+u/2AdbAUJWbsa+VH2YAfhOGJl1i62/s/2ZVbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512666; c=relaxed/simple;
	bh=oXBcpB2X7Q1GQfRJ5rdxx61ExjvgSM7R70X1rmKwNzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBp0Rp53X+VGanngIiAQnAMy6qSAS7XZ9Hs3HBcqkou3mkJseeCuxIyDj2ih5yeuCVngXPc6kLOSc91IrjLom7WktMPDxplcCO0VNZW7e4pYduEfu5sIA6Lk39i2inBcD0xJr/oZX2i3n72NzdgdCD6H+06kIoKz9ILUROkw4X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bU6TPEHV; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bU6TPEHV"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so52191cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512663; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7+0GbqIaCLafsgt6XdT41U/g4m+6NOKnU/2JcPrcNFv1fQQO6bXZsIv3BM/MHlY+8
         jyJ//AqBeQQNehTsXb6tjeCmoDyjgSoGzRrJtiglJhG/0PjoamCXYeKRwei/UEUXMlip
         w2v4M1StIuo/MoxHGkAEH6cMobTwkRNY7I4Uh/RPl8tsfR0g0mGYPxU0o5Sd2AvXHGfM
         Jx6T514uvc2EaU3RcWbLewZSXRKKBJYgK7CcWimGuKU8JdERFgOyNZj3OcVfVQyEaBVM
         ha8OKN5RiLdlW4hriLdsvBHyJPto2CgVZmLmrgY36xXtWKWGtiqTWw04arCaWQZmuVhc
         Djzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        fh=0w/iZn2Ajb22IGMNhpuaFJMuwkFXhOaUMeD+l4Un230=;
        b=lhs2yiQtLK0/HxStQKtySMy4QsAI3HaqHlVMzNry1xoFfkZNOR8JUxyKlLDJwqmLTI
         pSHwACVHgB55FPXisjbXollCMYFInQtoruKBMXZxdhvJ/6xj3yTWfAoAA38KAQe6mkSR
         nq2dd5/dQI3RHJuJD+oAgmSOwDIOOgjvBQlgblufke0bYMyF73tUd1cLgwBrsEh3lTFm
         zL2Q1DnT6TRWPh1Owg+GamW9l0FIrAUiYwMHdpQ2Sti0eYqwg0L+htCSV8nNtAFZdQbi
         m4SoOAidB+HSdrLMQIzVn2fEw15y2BlDImcMOgsfPNVk26qvbLm7hwvkxyDW8TgqMehp
         efpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512663; x=1790117463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        b=bU6TPEHVrgUdw4VzGDl+fR6H1CzL+0/Ymw4HFPlg4/Cr9Q0oCh2vmRQsq6NqvOlghy
         1iYs9LxTyDX9XPlfkdGI6rfdonESWO5ZbZT7bh+X9lFkiCWJ2SneMetq7ZFgj3IwKUDe
         GORCc9JLmRVBo6tUJyO27Zhkb54IN/fpjYmm7RghE3HXITPuJPBz8AMlp+1Y6UyP1F2C
         oQWG2U5BfUcM04s6FUlOO9Zpkaf//wJbIIz0Z+x1YNsXlmllupJNONi8YBmRyZIxl6o/
         cy+0hEmXg+UPfk+Wx1Ag0+P/Sm/sZhX0Nt42/caMIwPCHhKmDO4tnlrfzFxKQbIoAq1T
         ITog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512663; x=1790117463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        b=asacnOKxsRXZCqHFgNys69imZVG7t2ai/OPB4zRVyRugERLsWeBLhgVXb8VfzKMvRC
         iUA3WKHhBzOZ5QbGT3NTa4CqnSkeMF6V0w21Tl+A76YA2qFhrWLku2tS+EqHvu0K4TpP
         Bplt7aH3LyDsjrzvzht7axqdVtyWomX4/c/Tvx4uhlYM6sJXj/vpMpFGNhsYX4uuO2vh
         s0agChuZdSDipByUaDvuwgfPwzfnhp2/7nndT0LT0FZrVj/irYWcnbQD0C4RaBp36qJs
         770t6TfHMicF1+0GDV2Y+GQMRd9oaMczXtvQ/fYtiEI3CDeM9OQLm5jiHTefjS+5VSXk
         jyoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/+3VB0y9lRqcAerGfSR6rmB3jU436M64nnLLtej1gr+9faGTRQAoeozY0UssUfdu0UOWoiom5we9fLdvdpxvB@vger.kernel.org
X-Gm-Message-State: AFuF++njEZ+smjU6p1b8qb9R0+OgAJvL02awe+TNHAxQG/g9+LME+2au
	3R5xoxWJtyuR6EYMVqg0xdSWdB4ldt+r2GkoZFhPO5ia6yKQte2oQx81Z5wv23P34qCbGGs0uGF
	XSHQxT1JBTujGoQZoGE7wMO4n5Zg6YS1BEotT2fsz
X-Gm-Gg: AYBFou1YqUOrvjaipgL450KOtongHV8FZjCDIrPhhzPYIZklTLfIVXdTE6WQtW28/AT
	mKEbRrUN0dgjvPvvMp4ynbcAR82YuRSO5pqUp3lhVbQSIwV/ys/XiKET7Wv2Ovy5pJRqzWZtr+J
	siZ+yWgk7Z44Y/fXogD2LGU+Pfw/FTJ8UNBMaJYn3r8RdcRQ7Oc/7JJSxGpsiUeNkk6bR58Ohoo
	gr+wu/Rqc5+gtoXo01NOn4z5WmZLnWBtA8GmsRdoAoyk/wS6zKehLd+tBI0VG6DzfhXfJktOQCc
	y1jJJ/P0zsPK6HTgluRPELZUuc7YG8q9LS1g0GA9+VJliTCcwiTmRXhsw5F0QsaMNGX5nMC4RbM
	7I7246MJS6mukmH1hWMh4
X-Received: by 2002:a05:622a:8c9:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-5327e6ace28mr2653721cf.9.1789512662755; Tue, 15 Sep 2026
 15:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422173545.73144-1-atrajeev@linux.ibm.com>
 <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org> <E2E0C2AA-F6D5-427C-92DB-47777491C76D@linux.ibm.com>
In-Reply-To: <E2E0C2AA-F6D5-427C-92DB-47777491C76D@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:50:50 -0700
X-Gm-Features: AcwNN1XIZQl_Fcu5tzKsnk-K7Y_YYEuB6djG-D7hw48Py--fqNBKrneI5cYHQXs
Message-ID: <CAP-5=fV+NMfCNFFLnsySOoKnrE6c3TCJhO+BhZkbKjHitRD8Ag@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Fix crash in sched stats diff due to
 uninitialized perf_data structure
To: Venkat <venkat88@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
	Shivani.Nittor@ibm.com, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:07=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 24 Apr 2026, at 2:57=E2=80=AFPM, James Clark <james.clark@linaro.org=
> wrote:
> >
> >
> >
> > On 22/04/2026 18:35, Athira Rajeev wrote:
> >> perf sched stats diff fails sometimes with below logs:
> >>  # perf sched stats record ls
> >>  # perf sched stats diff
> >>   *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: term=
inated
> >>   Aborted (core dumped)
> >> Also in some runs, perf sched stats tests fails
> >>  ./perf test "perf sched stats tests"
> >>  92: perf sched stats tests                                          :=
 FAILED!
> >> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> >> =3D=3D172375=3D=3D    at 0x10393BD0: open_file_read (data.c:264)
> >> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
> >> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
> >> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
> >> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new (session.c:16=
9)
> >> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new (session.h:116)
> >> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff (built=
in-sched.c:4568)
> >> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> >> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
> >> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command (perf.c:3=
98)
> >> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
> >> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
> >> =3D=3D172375=3D=3D
> >> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> >> =3D=3D172375=3D=3D    at 0x10393D20: open_file_read (data.c:282)
> >> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
> >> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
> >> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
> >> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new (session.c:16=
9)
> >> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new (session.h:116)
> >> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff (built=
in-sched.c:4568)
> >> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> >> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
> >> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command (perf.c:3=
98)
> >> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
> >> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
> >> The valgrind logs and error message from the logs points to
> >> below snippet:
> >>      static int open_file_read(struct perf_data *data)
> >>      {
> >>             int flags =3D data->in_place_update ? O_RDWR : O_RDONLY;
> >>             struct stat st;
> >>             int fd;
> >>             fd =3D open(data->file.path, flags);
> >> The "struct perf_data" is defined here :
> >>     static int perf_sched__schedstat_diff(struct perf_sched *sched,
> >>                                       int argc, const char **argv)
> >>     {
> >>         struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> >>         struct list_head cpu_head_ses0, cpu_head_ses1;
> >>         struct perf_session *session[2];
> >>         struct perf_data data[2];
> >>         int ret =3D 0, err =3D 0;
> >>         static const char *defaults[] =3D {
> >>                 "perf.data.old",
> >>                 "perf.data",
> >>         };
> >> Here due to uninitialized "struct perf_data", the arguments to "open"
> >> is getting wrongly passed sometimes depending on value in stack.
> >> When perf_data__open() function calls open_file_read(),the
> >> "in_place_update" could contain garbage value.
> >> After initializing "struct perf_data" in perf_sched__schedstat_diff() =
function,
> >> perf sched stats tests runs without issues in multiple attempts and al=
so
> >> "perf sched stats diff" ran individual without issues.
> >> for i in {0..20}; do ./perf test "perf sched stats tests"; done
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >> ---
> >>  tools/perf/builtin-sched.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> >> index 555247568e7a..5d2740099eed 100644
> >> --- a/tools/perf/builtin-sched.c
> >> +++ b/tools/perf/builtin-sched.c
> >> @@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct per=
f_sched *sched,
> >>   struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> >>   struct list_head cpu_head_ses0, cpu_head_ses1;
> >>   struct perf_session *session[2];
> >> - struct perf_data data[2];
> >> + struct perf_data data[2] =3D { 0 };
> >>   int ret =3D 0, err =3D 0;
> >>   static const char *defaults[] =3D {
> >>   "perf.data.old",
>
> Tested this patch by applying on top of linux mainline kernel and it fixe=
s the issue.
>
> WithOut this Patch:
>
> # ./perf sched stats diff
> *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminate=
d
> Aborted (core dumped)
>
> # ./perf test -v "perf sched stats tests"
> --- start ---
> test child forked, pid 11151
> Basic perf sched stats record test
> Basic perf sched stats record test [Success]
> Basic perf sched stats report test
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.dysu3 ]
> Basic perf sched stats report test [Success]
> Basic perf sched stats live mode test
> Basic perf sched stats live mode test [Success]
> Basic perf sched stats diff test
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.dysu3 ]
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.p0lnk ]
> *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminate=
d
> /linux/tools/perf/tests/shell/perf_sched_stats.sh: line 67: 11170 Aborted=
                 (core dumped) perf sched stats diff "${perfdata}" "${perfd=
ata2}" > /dev/null
> Basic perf sched stats diff test [Failed]
> ---- end(-1) ----
>  92: perf sched stats tests                                          : FA=
ILED!
>
> With This Patch:
>
> #
> for i in {1..20}; do
>     ./perf test "perf sched stats tests"
> done
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>
> Please add below tag.
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Regards,
> Venkat.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> >
> > I had a quick look for other instances of the same thing and didn't see=
 any.
>
>
