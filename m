Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCrU05CT"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE4BE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 16:22:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50aa698b384so1129e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700526156; x=1701130956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSZDmH1lmOHmDaW+5zk2UkeOzV5JR2ghLJakWOUafsQ=;
        b=pCrU05CTRbjjWe1SZAiGYLBkWN12AhHY1l3wsBkVvVGuyF5j7sf77P7w4N08kWZMGZ
         2KrteqZxfhf0h46iO7gqV/6nnkNvjou5jG68K2zE3pC8l5Ua5OXz6RUVGUo4/WhKraM6
         jvJpfXwmwLhzYvzLyqMFSWY/zI1KFKPigAtA11KSi1ubI2thkdJ1bH9kquBo5euBMRbR
         m0XhF5gy4icvUI1+0xBoF0cFdpiOEqwEXfrw+xxbyxn4VKNhmtSVv2yC6BHW6v95A8zr
         mpJ9ikc/bf/7Nq/gsBjWJUcQAXfvW7/Ise0EKwGgi3vjVSEg6ursv/I6s4gGTVmmGJWn
         hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700526156; x=1701130956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSZDmH1lmOHmDaW+5zk2UkeOzV5JR2ghLJakWOUafsQ=;
        b=PnWz6wgl/kem1veyDGrIiIZbVFOeXQgfqVdwoMAA+1NyQaut8nOJu2DboYqQAWAnUm
         NKCULoPow0kVFQ3SLrLCyB4iUqgxmmM6kGCJzUPFelqpfz4++1sbAOLaJ614kJwtXzlA
         bUr5e09eizehljmXDFzKXTBNmXpbAUgPw5Rxm9v2kw6gnqfpODRnIwWrVafY8o0/KESH
         pkxFH88hDpNED6sm3ZNo/5twPYMeSr4RbW99Rxiv1nKy76W3wCPF550x+rXJ8Gc4OynM
         HRUqIq7drV5+aUt4vVRxdOaTlqKfCioFfccJ78V6Vco5/X/yK/Ecp0hDGI0iSxwYO4sc
         QayA==
X-Gm-Message-State: AOJu0YzvO5rCvX6UdTH0ikyeigmeWT4LrBV8mxEgr0d4C+Q7KU4rfJJu
	wR2JYVCZ04XnpzEm94w5bKue1bh4bBusqK2NNwkhaA==
X-Google-Smtp-Source: AGHT+IH8hvQTHYXJu/GZqZQTccj5xJ94NpUXMb/QmGRXcQJ27uSCNO6Ggsyzf22kqcVTLpDcZnncKcgovuIIJqHrYUk=
X-Received: by 2002:ac2:54b4:0:b0:505:7c88:9e45 with SMTP id
 w20-20020ac254b4000000b005057c889e45mr215951lfk.0.1700526156322; Mon, 20 Nov
 2023 16:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107184020.1497571-1-kan.liang@linux.intel.com> <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
In-Reply-To: <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 20 Nov 2023 16:22:24 -0800
Message-ID: <CAP-5=fVqWc70w1twQdOK3u6dzS_u3ELAtcr--qmiP5x+vkbK+w@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Basic branch counter support
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	tinghao.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 8:12=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> Hi Ian,
>
> On 2023-11-07 1:40 p.m., kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Add a basic test for the branch counter feature.
> >
> > The test verifies that
> > - The new filter can be successfully applied on the supported platforms=
.
> > - The counter value can be outputted via the perf report -D
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >
> > Changes since V2:
> > - Update the output msg for the skipped case (Ian)
> >
>
> Any comments for this patch?

Confirmed the wildcard works as expected.
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Kan
>
> >  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 4fbc74805d52..cc207a16ae24 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -11,6 +11,9 @@ err=3D0
> >  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >  testprog=3D"perf test -w thloop"
> >  testsym=3D"test_loop"
> > +cpu_pmu_dir=3D"/sys/bus/event_source/devices/cpu*"
> > +br_cntr_file=3D"/caps/branch_counter_nr"
> > +br_cntr_output=3D"branch stack counters"
> >
> >  cleanup() {
> >    rm -rf "${perfdata}"
> > @@ -154,10 +157,37 @@ test_workload() {
> >    echo "Basic target workload test [Success]"
> >  }
> >
> > +test_branch_counter() {
> > +  echo "Basic branch counter test"
> > +  # Check if the branch counter feature is supported
> > +  for dir in $cpu_pmu_dir
> > +  do
> > +    if [ ! -e "$dir$br_cntr_file" ]
> > +    then
> > +      echo "branch counter feature not supported on all core PMUs ($di=
r) [Skipped]"
> > +      return
> > +    fi
> > +  done
> > +  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev=
/null
> > +  then
> > +    echo "Basic branch counter test [Failed record]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
> > +  then
> > +    echo "Basic branch record test [Failed missing output]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Basic branch counter test [Success]"
> > +}
> > +
> >  test_per_thread
> >  test_register_capture
> >  test_system_wide
> >  test_workload
> > +test_branch_counter
> >
> >  cleanup
> >  exit $err
