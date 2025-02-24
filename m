Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758261898ED
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389674; cv=none; b=ApinBYD8LK5tMRexnTLNbd72YAYGqbqJMVeav/ATZVvoWtbExvBJ0f2QaVyVMkoj68cEjgLwRbY3zA0cLRSH+1Ea8HutKZtGDUBwLJBLv8cc88ntpri5f/5MYWtWBlCzWZ9RmB0NzeupBOBAsykNYHKskoNLjG6NgVVMJ1Fa/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389674; c=relaxed/simple;
	bh=E8nU4giWTUKgyDZl2nz5vdGFPbe6n5FWQD7Os6YV7Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkKuXxOUC9Jk/H47tTSCipKtf7gamNjtzBv3jOH1MAt6bBBdAzvx014dPMw/yjcue/h4zMBPF7SASOjnicVps5REIX8Y0O4mCZVz1sCEvCwlNjUbpsGsRKCq6zd7hjJGQk1pvLOSfesfM6LOYDSxniUxfx/hYtOxhPiE+YXgssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzXSPkCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzXSPkCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740389671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdSFC/NWX5dRrWdCxqzO+/QnaU/bGpQWIT5COSO8Slo=;
	b=PzXSPkCIfg2NGNBG7m9aWrlhV1gARcHXqEhMjEcrR5xnVfeiiif4OaLeFh9jfSM/u1Gajs
	J0shB4Kmxbc5BYFEdRtPqoDfPNY1a7r6DcJLiL1E2zbo9bkKevpY2lM+Q3j8xhsSBJEDzE
	O7/UV+eHBaO5VNSaUXoiEK4CD5lcJlk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-qrSzR93cMEGFjMzvKSV2ew-1; Mon, 24 Feb 2025 04:34:29 -0500
X-MC-Unique: qrSzR93cMEGFjMzvKSV2ew-1
X-Mimecast-MFC-AGG-ID: qrSzR93cMEGFjMzvKSV2ew_1740389668
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so14223371a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 01:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740389668; x=1740994468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdSFC/NWX5dRrWdCxqzO+/QnaU/bGpQWIT5COSO8Slo=;
        b=RY05qEpQzUsvTbz0ljW89rudQDfbaK2TDhO6oG0sO4TJYYDFLKP8TnzAPnzW66sU9V
         wSZI6V7KHVjwcMMUVz/Bt0grv+12FSH82rtWgi+FPUrTU78nBAjHxte3bcpE8NLvjwuy
         sMtKCwVfPBNc28El/ZAqN8BgEO2Ict0my4ABI5cc5Ck8PUPj9n5CI0ax4vdZzIcLrlbl
         VuIUQ8mudVi/vvjXmdqYQ5sSKnD/uTIKBiyQGuXvEjsdRAuzAWTN1bbTwFLvzFjK6sgR
         PFPjr8XXJ1M4E5td6F0qzyhVq+YpZxUEQpMM5gMkbVf9Tu3EKy1d2fqOtgsTlC+Z/ais
         ExgA==
X-Forwarded-Encrypted: i=1; AJvYcCWGNyc7pEm1H/2Dr7qXR+xw2Ms3fLvMECx3adxVHWncN9GpQCsL/+IaaoeOOCfysMJmBS73c+hJfVQSjFsrsHcB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5sI7cIwRybxhLMuncMDBTk7f2PHNhXi0HZ/VYXtDZuNSX9sO
	YjqfgD51mMjPZV36ZubWuUe3iiOn1G1j7bKqYLZCBj7qI6egXYWnkMXpDHlvdBdILElWEtL06G+
	aGASs0yUESz3GmfMgLkJ+rWF33hKoPCJvPyTZsKpbkuS/0FRVZBQxpxEfgPHYFmPdXNUHBGAyM+
	sLD4W7oUpuqOmgrEuDu5TRslIusErjS3LwKxHM+jMHuQ==
X-Gm-Gg: ASbGncuxt3xbx2ki900dlV2akJjt5PDOurD8j/+GLlu1mekSKZHAOYtIUwwR+G9pa8C
	sWP42YqiDqz/GVRjFtsA7GOQEOzaxONTQpcOCVkuxvtYf3bb25Qg5TscPEsrE1Ft8+d7WXbIX+Q
	==
X-Received: by 2002:a17:90b:2f4b:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-2fce75e3336mr25582590a91.0.1740389667964;
        Mon, 24 Feb 2025 01:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7qGcGXKihErNmzjH+5ghfb0FKaRWncF5BZVbk0bJI4SW+bjntu2atlWJCOwbZkOMIz//Ck82rYUFF0f/j1DA=
X-Received: by 2002:a17:90b:2f4b:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-2fce75e3336mr25582556a91.0.1740389667669; Mon, 24 Feb 2025
 01:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122231233.79509-1-vmolnaro@redhat.com> <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com> <Z4vv0_-GP5bbNPAj@google.com>
 <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
In-Reply-To: <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Mon, 24 Feb 2025 17:34:15 +0800
X-Gm-Features: AWEUYZknDoOyrQWp_KHoI1NXGoMC_qztdRXQuzGnLlvgbQteOK8-dx0HB0Qd-MY
Message-ID: <CAATMXfmtSghSj1J91SVimNTLWdi-=--xpyhFn6RwY2b12y+UmQ@mail.gmail.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat' result
To: Namhyung Kim <namhyung@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, irogers@google.com, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:59=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> On Sun, Jan 19, 2025 at 2:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrote:
> > >
> > >
> > > On 12/10/24 16:20, Veronika Molnarova wrote:
> > > >
> > > >
> > > > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> > > >> From: Veronika Molnarova <vmolnaro@redhat.com>
> > > >>
> > > >> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' =
output
> > > >> due to a poor design. Firstly, having the 'set -e' option with a t=
rap
> > > >> catching the sigexit causes the shell to exit immediately if 'perf=
 stat' ends
> > > >> with any non-zero value, which is then caught by the trap reportin=
g an
> > > >> unexpected signal. This causes events that should be parsed by the=
 if-else
> > > >> statement to be caught by the trap handler and are reported as err=
ors:
> > > >>
> > > >>     $ perf test -vv "perf all pmu"
> > > >>     Testing i915/actual-frequency/
> > > >>     Unexpected signal in main
> > > >>     Error:
> > > >>     Access to performance monitoring and observability operations =
is limited.
> > > >>
> > > >> Secondly, the if-else branches are not exclusive as the checking i=
f the
> > > >> event is present in the output log covers also the "<not supported=
>"
> > > >> events, which should be accepted, and also the "Bad name events", =
which
> > > >> should be rejected.
> > > >>
> > > >> Remove the "set -e" option from the test case, correctly parse the
> > > >> "perf stat" output log and check its return value. Add the missing
> > > >> outputs for the 'perf stat' result and also add logs messages to
> > > >> report the branch that parsed the event for more info.
> > > >
> > > > Hi Ian,
> > > >
> > > > is there anything that I am missing? If so would be great to know t=
he idea
> > > > of your patch. This issue is getting quite old so would be great to=
 get a proper
> > > > fix together.
> > > >
> > > > Thanks,
> > > > Veronika
> > >
> > > Hello,
> > >
> > > just wanted to ping the patch. Would be great to sort it out and clos=
e the issue.
> >
> > Ian, are you ok with this?
> >
>
> Just ping again for this patch, can this fix be acked?
>
> And I already tested this patch and it works well on the ppc64le system.
>
> Tested-by: Qiao Zhao <qzhao@redhat.com>

Revert the Tested-by, and when more tests on Intel EMR system, and show oth=
er
"Bad event name" and " value too big for format (umask)" errors.
This patch needs more tests and rewrites.

- Qiao

>
> - Qiao
>
> > Thanks,
> > Namhyung
> >
> > > >>
> > > >> Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in a=
ll PMU test")
> > > >> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > > >> ---
> > > >>  tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++---=
-----
> > > >>  1 file changed, 34 insertions(+), 14 deletions(-)
> > > >>
> > > >> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/t=
ests/shell/stat_all_pmu.sh
> > > >> index 8b148b300be1131e..9c466c0efa857fc2 100755
> > > >> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > > >> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > > >> @@ -2,7 +2,6 @@
> > > >>  # perf all PMU test (exclusive)
> > > >>  # SPDX-License-Identifier: GPL-2.0
> > > >>
> > > >> -set -e
> > > >>  err=3D0
> > > >>  result=3D""
> > > >>
> > > >> @@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
> > > >>  # Test all PMU events; however exclude parameterized ones (name c=
ontains '?')
> > > >>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:gra=
ph:]]\+[[:space:]]//g')
> > > >>  do
> > > >> -  echo "Testing $p"
> > > >> -  result=3D$(perf stat -e "$p" true 2>&1)
> > > >> -  if echo "$result" | grep -q "$p"
> > > >> +  echo -n "Testing $p -- "
> > > >> +  output=3D$(perf stat -e "$p" true 2>&1)
> > > >> +  stat_result=3D$?
> > > >> +  if echo "$output" | grep -q "$p"
> > > >>    then
> > > >>      # Event seen in output.
> > > >> -    continue
> > > >> -  fi
> > > >> -  if echo "$result" | grep -q "<not supported>"
> > > >> -  then
> > > >> -    # Event not supported, so ignore.
> > > >> -    continue
> > > >> +    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not=
 supported>"
> > > >> +    then
> > > >> +      # Event supported.
> > > >> +      echo "supported"
> > > >> +      continue
> > > >> +    elif echo "$output" | grep -q "<not supported>"
> > > >> +    then
> > > >> +      # Event not supported, so ignore.
> > > >> +      echo "not supported"
> > > >> +      continue
> > > >> +    elif echo "$output" | grep -q "No permission to enable"
> > > >> +    then
> > > >> +      # No permissions, so ignore.
> > > >> +      echo "no permission to enable"
> > > >> +      continue
> > > >> +    elif echo "$output" | grep -q "Bad event name"
> > > >> +    then
> > > >> +      # Non-existent event.
> > > >> +      echo "Error: Bad event name"
> > > >> +      echo "$output"
> > > >> +      err=3D1
> > > >> +      continue
> > > >> +    fi
> > > >>    fi
> > > >> -  if echo "$result" | grep -q "Access to performance monitoring a=
nd observability operations is limited."
> > > >> +
> > > >> +  if echo "$output" | grep -q "Access to performance monitoring a=
nd observability operations is limited."
> > > >>    then
> > > >>      # Access is limited, so ignore.
> > > >> +    echo "access limited"
> > > >>      continue
> > > >>    fi
> > > >>
> > > >>    # We failed to see the event and it is supported. Possibly the =
workload was
> > > >>    # too small so retry with something longer.
> > > >> -  result=3D$(perf stat -e "$p" perf bench internals synthesize 2>=
&1)
> > > >> -  if echo "$result" | grep -q "$p"
> > > >> +  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>=
&1)
> > > >> +  if echo "$output" | grep -q "$p"
> > > >>    then
> > > >>      # Event seen in output.
> > > >> +    echo "supported"
> > > >>      continue
> > > >>    fi
> > > >>    echo "Error: event '$p' not printed in:"
> > > >> -  echo "$result"
> > > >> +  echo "$output"
> > > >>    err=3D1
> > > >>  done
> > > >>
> > >
> >

