Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1F384CF7
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499500; cv=pass; b=Aku99mvmwxY4slFt8bPiercd6fTfzhvmjW5Hyhxc7TDE3d3CDel65hht0fSEtb7ZFfIKxKfi3ovJNTXloaHMcLU7PNdwa3z+SK6MJADsr3v2tDT230/92YDqTUOqYwlCJPsYA+MnAc53iyTn7opvKNFR0aaGC5FPQbs2MJT9PMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499500; c=relaxed/simple;
	bh=41+oM2ikuQq7rxR1M+najByvYLxZWU2xnx6uHMrP8lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVECN/Gykd7jZUJthUofsMEaxyUA/z0NStrchSbCnTKC7TfWs1CDWVdwx3HjY/9aVoo8gnLc7GgPnRlVAdEI+PD3jqdrC5iO8scDT2UteOtBIIWCDL6Jop8C75Vs+Lxjm73YvIW7/SzTnRoLzs/440j8EXTPWgVJ6F7aI5UwIfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfSJu8CI; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfSJu8CI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2911f93cso69075ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499499; cv=none;
        d=google.com; s=arc-20240605;
        b=Wt4EPtKT16xQJBogG8IyjE838sVga75T1eb1TfDjDqy4/w+bUB0YBNf4AsABJmKtdP
         V6Dm6MR+mkknMuMwIgqvfQy70vBuhDoY0Rd7L8prF+Ux3+DgdrNqxZH9RbhIzQ+4B0Jo
         KJ+1q5uudVguaCYhP4t/wamj9cOIkwUxxRzqOm+4pTNzONNdWzPADERiJPJH76NHtksx
         yaM8EoHixXpyLxmfaPeEh8ieVrN5GALJIV8gNJI4TQHpi7xX0ziGEeKiHpwEBU29qxaC
         Sk55gKutMDZfjEI9zf3utlFiW6wWoB/kcTAdujkPMJrnXG5ANrXiPdswBggk8FDASkDx
         0zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9vn464LDRIjxCyOkoYNNcQi51FImJ4qYDaY4XfiXZZU=;
        fh=2jS4BVZiTxq98gDcbxEl/RDS4ErmtCdheg787uCmyVY=;
        b=k5JKx3gSSTRym62KkxwIjFf7lN+8fys5Zk9NYMnplaEemG1GT3v73yiwBZvIFUZEQN
         ycmBs9thS613sERfTJ8YoE5YeQP83niTntbygKHju+Zyo2ha+aS7awysrbZ2I/ePT9Ug
         Oh3GZvVXd5Du4/K5v67YH/AAzldSUuEK7Mn/xwI0GcOJaZUmOvjjxwB9dYZYyyyp0jrq
         2VALcR5DjLznLLCwHKchClCOESMiIpjm9c0jhCT6jRqkKtseKnoWmmFRH6ct5mQxn2iY
         omcoWiTLByrFEVWKsvky7UzGAKlCzOcQfCoudf+LptVoxg4oVkK5AHZty7Jlhe9YUSPD
         nDow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499499; x=1781104299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vn464LDRIjxCyOkoYNNcQi51FImJ4qYDaY4XfiXZZU=;
        b=UfSJu8CIsvPnQc7I99Ku/c9PusF56xodyz+rtHQSooD9qu5GuxHqnJCXWCorJpsO1z
         T9748961gZVEcsuBdceqIqsMbXJWbCoD/DcEN2sRb1gT9y3HGOShiLuTTYCimS4qxgvj
         T9QSK1elHaso1MmhpLsmDEx21qnmCJlwfJyZotYJrx7T/9uMWGrG1QBtMrkLA8j6EU7d
         rsv1/GW6x0r8/Pi3ioFqcvBZVzFOnOI7OMIJX2UpgqN0hgFy2EDxX5TpkuRNOuO0NVEc
         8Bn6uUs7E4vwDDJIkswIlQdK7DhVQv3AYwQKtcsw0Ybu+5QjJV7bXvi/PAOPeT8n27LT
         uScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499499; x=1781104299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vn464LDRIjxCyOkoYNNcQi51FImJ4qYDaY4XfiXZZU=;
        b=DSH74LUl5gv3/jGszNQQJHgR4slBFJqEtz/YOocdLuMtSIzkDLQP0w744lSS5uyID+
         niyKL5Sp1yeXzNCF4mrZ3BMPibu/tUVaJ9fi0DMtvbPYrTyEaYeJQS3lWz9ZxQcOdfiO
         GzBmeRU+ejbqkPlHkpB6PGxEDrMnac1bpv6f2Sb830jbcT7CV1dJZmMos1TrFJylO4jV
         NyYigQURnI3zX9XjrLe0G3lTAJPcxqTjekV2lJg1MwbS2uyHN0/NkwUme6vYBFPlxt/c
         o26NnqFiUwLBMY6jyCAk1LEI3shY1r4hYnEZoCbbkZsy/xOGF1vEbDzGTUOXRo4LTaHL
         700A==
X-Forwarded-Encrypted: i=1; AFNElJ+qWfUjp24SrY8DOiygjrnhuAtFn7siZ+br8q+Eqiguxx2xAv8sBL1enIC3BSiTuEtrMf237/mzVOX2xiSgX083@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoenqEUG357jxdRGpOvtaKnSYOzco+8BPduoHZM6xUC+lhMpL
	8RYVVRjG05v55OyGcM+KjMEzqHj7qzkxvG9Hyt5d0wSiQDuL43UVdVpJzehEQFLjxv88gkXjt5J
	jXfrC/m82haPfa1oSWXXXEMMiSFEYJ/9lYOu0L1XZ
X-Gm-Gg: Acq92OFNxKNvI4kP6ciRg4KjDTXU6aqJHF1SiTAGrJE0RYaW4LGotkJsJ1VsduoV9t5
	uXfz+4YyG1ox12ULtoF3QSpiqCAFkb+vFUtWag58AQgZ3saBz/BS1AN9Vp7MYOzdUxzppC+wSCx
	SfbDCErtwQCHYsaQEIyqlLI+7g26G2JJffCUByo+oF3zeTxTSuP8GCXXRrmjnhh/4AT39aa38kS
	76N/bcA8CXylasnQJ6fYq+wMfn/6uaIssw4CLZrqAw/osSPL5f7S56eDhvOPo9i/pgrucDkas/p
	DIbL7Y1kCjww7GzqROOU/1iFVFXlSlyOmNY/7usft6Jcm1BS
X-Received: by 2002:a17:903:1a03:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2c16c07f90bmr2345485ad.2.1780499498020; Wed, 03 Jun 2026
 08:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-2-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:11:26 -0700
X-Gm-Features: AVHnY4J8au99Z3GweasrHNoI5cWjX3UsKEAAX1o4RAqmk20U_E2EFly2riKc0N8
Message-ID: <CAP-5=fX43wAtXrcBbf6SGM1c6=XK-T+tfM2pYU9foOv+ePxDKw@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf sample: Add file_offset field to struct perf_sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add a file_offset field to struct perf_sample so that event processing
> callbacks can report the byte offset of the problematic event in
> perf.data, letting users cross-reference with 'perf report -D' output.
>
> Set sample.file_offset in perf_session__deliver_event(), which is the
> common entry point for both file mode (mmap'd offset) and pipe mode
> (running byte counter from __perf_session__process_pipe_events).
>
> The assignment is placed after evsel__parse_sample(), which zeroes
> the struct via memset.
>
> Preserve file_offset through the deferred callchain delivery path by
> storing it in struct deferred_event and restoring it after
> evlist__parse_sample() in both evlist__deliver_deferred_callchain()
> and session__flush_deferred_samples().
>
> Subsequent patches will use this field in skip/stop warning messages.
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/sample.h  | 2 ++
>  tools/perf/util/session.c | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index e556c9b656ea9cd6..c4eae8b2fd06035a 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -158,6 +158,8 @@ struct perf_sample {
>         u64 code_page_size;
>         /** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
>         u64 cgroup;
> +       /** @file_offset: Byte offset of this event in the perf.data file=
. */
> +       u64 file_offset;
>         /** @flags: Extra flag data from auxiliary events like intel-pt. =
*/
>         u32 flags;
>         /** @machine_pid: The guest machine pid derived from the sample i=
d. */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index e2e821b77766dbfc..7996787d742e32c6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1824,6 +1824,7 @@ static int evlist__deliver_sample(struct evlist *ev=
list, const struct perf_tool
>  struct deferred_event {
>         struct list_head list;
>         union perf_event *event;
> +       u64 file_offset;
>  };
>
>  /*
> @@ -1858,6 +1859,7 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
>                         perf_sample__exit(&orig_sample);
>                         break;
>                 }
> +               orig_sample.file_offset =3D de->file_offset;
>
>                 if (sample->tid !=3D orig_sample.tid) {
>                         perf_sample__exit(&orig_sample);
> @@ -1906,6 +1908,7 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
>                         perf_sample__exit(&sample);
>                         break;
>                 }
> +               sample.file_offset =3D de->file_offset;
>
>                 sample.evsel =3D evlist__id2evsel(evlist, sample.id);
>                 ret =3D evlist__deliver_sample(evlist, tool, de->event,
> @@ -1984,6 +1987,7 @@ static int machines__deliver_event(struct machines =
*machines,
>                                 return -ENOMEM;
>                         }
>                         memcpy(de->event, event, sz);
> +                       de->file_offset =3D sample->file_offset;
>                         list_add_tail(&de->list, &evlist->deferred_sample=
s);
>                         return 0;
>                 }
> @@ -2126,6 +2130,7 @@ static int perf_session__deliver_event(struct perf_=
session *session,
>                 pr_err("Can't parse sample, err =3D %d\n", ret);
>                 goto out;
>         }
> +       sample.file_offset =3D file_offset;
>         /*
>          * evsel__parse_sample() doesn't populate machine_pid/vcpu,
>          * which are needed by machines__find_for_cpumode() to
> --
> 2.54.0
>
