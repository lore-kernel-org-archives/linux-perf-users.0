Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403871EDA34
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380381; cv=none; b=oLuXJJc994l+pMjyf+bnKoE77xHINAeW6I+jvdUJ8owSX2zrqx4sE3C8E8hT78Lr75hvVwVRX5/rXQ4kd09bzO4KZFj/cGg1ZnzIM3J5Nn46TN/QJcWsX4feCK+aQCO2Nsv38K2jFzOj0/sYXHqrcAiUAVYdktY7/31+nHLxnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380381; c=relaxed/simple;
	bh=nFEavu4Ewv/3qJrHuRj0dePzP+eIja+IoXlXLHWI6kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rALoFIq3EH1fdbyZiDAWJZ8mZNX5ew6NjmBLNm3CiYEsZ+agI/sRZ4YdrFvkw7DeoHzMvn/pRgjCNYx94uG5ACKM7vanZVeVXw8OJkmAZE3QrzHClKCo163z6jPCHyKp0GICzp+gURRdCzuragG9/14RT43rOCctQfzvFOtT14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4njQr4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4njQr4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740380378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Xjv6Wg61SE3BMhCZvWBcequxsAP/eykX/Cti4AqIAE=;
	b=c4njQr4wpLHgq16KVRrb0AtCQgSns9w+9KYlTOUTsigPpAJPDzboCvbaHBTRN0YWAtaGBW
	gcW1g2leaPelCPxycfZRDfoYjk3QH4lYEIXV3/27RfU6Vcmwaaa95sALFqFEGaGiiUQ+J8
	edboqXFerzzfBN2jHp0jVCBd8SFQHPs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-9m52nPjDM7uKJnCH9lPIbQ-1; Mon, 24 Feb 2025 01:59:36 -0500
X-MC-Unique: 9m52nPjDM7uKJnCH9lPIbQ-1
X-Mimecast-MFC-AGG-ID: 9m52nPjDM7uKJnCH9lPIbQ_1740380375
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc261eca15so9828089a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Feb 2025 22:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380375; x=1740985175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Xjv6Wg61SE3BMhCZvWBcequxsAP/eykX/Cti4AqIAE=;
        b=IjU8x5sK1pthh3Ykm2VnE6Sh6S7/5tUPYNF4PCxKlNOWadxAkhCyykbm9ar9AeUBzb
         UOxaeXpQ1tsn0YrGO8fjrUNMCDa2DFIYGKwy0VVRC3fKBJ9le9dGo7XaePsfZINkJXhk
         BvUEkyx08Iji/40w9kmXOBFIOWCcDzYkWfeTXqe+bbjr3tM5VyQb/bropnEnlJWTDyqG
         +QbsJeaoqjVMoJoKQnOOojP0+gseJG+lU2uZCcoOykdIHPzE1+c6VKqqG3PLqff8iCYW
         mYz2pjpEYCIUcKfPizTyGz7TFIYcN6GVaz3eBiKqGAHQ6sB/4RlSx8aUg6DbKKpf2w0j
         zPig==
X-Forwarded-Encrypted: i=1; AJvYcCVQgpfXquri2lC9J7WRnZj6OqegsVVqwvHC4ypNnHYRvID1LWMOsWgKuFXMb5NelbANgcjDjywpQFVxl+s7o/X7@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+GPGVA9KueK5GS55w0WDXAY5NKJgdbL+3StZHA2TyEdmsc3Z
	Eib8T3HLsz/VCXXt5zqy/WKML74ltS/ymPZOmzoZBqqJZV1E99kit6ycM5UhbX95dBrgPJPU3jB
	jBLPFQHmuj/XEOlbqCal/AkJh6OvCn5z5Q0t3/XXKVXwgQIWI1i7KGihKbroXgty6mmsaSuoQ4O
	AMg5JsDzIHRNBQhSSNEPklQc3hZMSUrVC4gxXXjlRe7g==
X-Gm-Gg: ASbGncu2F2I0rnbPhWHC8AzftgFaibj54KYFLC3mtgldV7+ozwXQySXB7DrQxzm7i8K
	bGpxaWYZGy6Y7T1nElFKckBPkiOdCb5HHuqxEMy3Wxl+I+zh3tBle1vuPBBSCvgiNrN9zdk+Y1A
	==
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2fccc97a25bmr27992083a91.11.1740380375065;
        Sun, 23 Feb 2025 22:59:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPtfDmUsGVjz5x/+BNbagxX0tEUSX8ZGxGEgkmmPjMQXpC2xI5eCWFURiqFperPzPA7OdejAp1OymiCWVQUQY=
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2fccc97a25bmr27992033a91.11.1740380374255; Sun, 23 Feb 2025
 22:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122231233.79509-1-vmolnaro@redhat.com> <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com> <Z4vv0_-GP5bbNPAj@google.com>
In-Reply-To: <Z4vv0_-GP5bbNPAj@google.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Mon, 24 Feb 2025 14:59:21 +0800
X-Gm-Features: AWEUYZlVx0jOvOB-zHhvanBXcWXLxrNXxXiOZBQXqA7hfTAtL_Qe12bQTyteE6I
Message-ID: <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat' result
To: Namhyung Kim <namhyung@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, irogers@google.com, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 2:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrote:
> >
> >
> > On 12/10/24 16:20, Veronika Molnarova wrote:
> > >
> > >
> > > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> > >> From: Veronika Molnarova <vmolnaro@redhat.com>
> > >>
> > >> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' ou=
tput
> > >> due to a poor design. Firstly, having the 'set -e' option with a tra=
p
> > >> catching the sigexit causes the shell to exit immediately if 'perf s=
tat' ends
> > >> with any non-zero value, which is then caught by the trap reporting =
an
> > >> unexpected signal. This causes events that should be parsed by the i=
f-else
> > >> statement to be caught by the trap handler and are reported as error=
s:
> > >>
> > >>     $ perf test -vv "perf all pmu"
> > >>     Testing i915/actual-frequency/
> > >>     Unexpected signal in main
> > >>     Error:
> > >>     Access to performance monitoring and observability operations is=
 limited.
> > >>
> > >> Secondly, the if-else branches are not exclusive as the checking if =
the
> > >> event is present in the output log covers also the "<not supported>"
> > >> events, which should be accepted, and also the "Bad name events", wh=
ich
> > >> should be rejected.
> > >>
> > >> Remove the "set -e" option from the test case, correctly parse the
> > >> "perf stat" output log and check its return value. Add the missing
> > >> outputs for the 'perf stat' result and also add logs messages to
> > >> report the branch that parsed the event for more info.
> > >
> > > Hi Ian,
> > >
> > > is there anything that I am missing? If so would be great to know the=
 idea
> > > of your patch. This issue is getting quite old so would be great to g=
et a proper
> > > fix together.
> > >
> > > Thanks,
> > > Veronika
> >
> > Hello,
> >
> > just wanted to ping the patch. Would be great to sort it out and close =
the issue.
>
> Ian, are you ok with this?
>

Just ping again for this patch, can this fix be acked?

And I already tested this patch and it works well on the ppc64le system.

Tested-by: Qiao Zhao <qzhao@redhat.com>

- Qiao

> Thanks,
> Namhyung
>
> > >>
> > >> Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in all=
 PMU test")
> > >> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > >> ---
> > >>  tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++-----=
---
> > >>  1 file changed, 34 insertions(+), 14 deletions(-)
> > >>
> > >> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tes=
ts/shell/stat_all_pmu.sh
> > >> index 8b148b300be1131e..9c466c0efa857fc2 100755
> > >> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > >> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > >> @@ -2,7 +2,6 @@
> > >>  # perf all PMU test (exclusive)
> > >>  # SPDX-License-Identifier: GPL-2.0
> > >>
> > >> -set -e
> > >>  err=3D0
> > >>  result=3D""
> > >>
> > >> @@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
> > >>  # Test all PMU events; however exclude parameterized ones (name con=
tains '?')
> > >>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph=
:]]\+[[:space:]]//g')
> > >>  do
> > >> -  echo "Testing $p"
> > >> -  result=3D$(perf stat -e "$p" true 2>&1)
> > >> -  if echo "$result" | grep -q "$p"
> > >> +  echo -n "Testing $p -- "
> > >> +  output=3D$(perf stat -e "$p" true 2>&1)
> > >> +  stat_result=3D$?
> > >> +  if echo "$output" | grep -q "$p"
> > >>    then
> > >>      # Event seen in output.
> > >> -    continue
> > >> -  fi
> > >> -  if echo "$result" | grep -q "<not supported>"
> > >> -  then
> > >> -    # Event not supported, so ignore.
> > >> -    continue
> > >> +    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not s=
upported>"
> > >> +    then
> > >> +      # Event supported.
> > >> +      echo "supported"
> > >> +      continue
> > >> +    elif echo "$output" | grep -q "<not supported>"
> > >> +    then
> > >> +      # Event not supported, so ignore.
> > >> +      echo "not supported"
> > >> +      continue
> > >> +    elif echo "$output" | grep -q "No permission to enable"
> > >> +    then
> > >> +      # No permissions, so ignore.
> > >> +      echo "no permission to enable"
> > >> +      continue
> > >> +    elif echo "$output" | grep -q "Bad event name"
> > >> +    then
> > >> +      # Non-existent event.
> > >> +      echo "Error: Bad event name"
> > >> +      echo "$output"
> > >> +      err=3D1
> > >> +      continue
> > >> +    fi
> > >>    fi
> > >> -  if echo "$result" | grep -q "Access to performance monitoring and=
 observability operations is limited."
> > >> +
> > >> +  if echo "$output" | grep -q "Access to performance monitoring and=
 observability operations is limited."
> > >>    then
> > >>      # Access is limited, so ignore.
> > >> +    echo "access limited"
> > >>      continue
> > >>    fi
> > >>
> > >>    # We failed to see the event and it is supported. Possibly the wo=
rkload was
> > >>    # too small so retry with something longer.
> > >> -  result=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1=
)
> > >> -  if echo "$result" | grep -q "$p"
> > >> +  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1=
)
> > >> +  if echo "$output" | grep -q "$p"
> > >>    then
> > >>      # Event seen in output.
> > >> +    echo "supported"
> > >>      continue
> > >>    fi
> > >>    echo "Error: event '$p' not printed in:"
> > >> -  echo "$result"
> > >> +  echo "$output"
> > >>    err=3D1
> > >>  done
> > >>
> >
>

