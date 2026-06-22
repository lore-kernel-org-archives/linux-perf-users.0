Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC505372661
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172769; cv=pass; b=GN1ZyhaUI5u+0bNTiTHugBWCcomdKzWphTMbuJ2UQueRbZ2bVV6IO9Ux5WD1y3QhoaYp7Q1R5WXFv3X/pcHw7FDM+5lXOeay/CZsVjHzjhpP3nYibCxtGS6gDu4kMUVtIW0uHAvVNH8+ar9m/kQRhLRZ4MGYV1lw4xvo0P9VViU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172769; c=relaxed/simple;
	bh=K51GHx82gzsQATgtTITm/HOcXusIVMempY6163wk2Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqEd1GxkUGEfSt6z6WO7ip32gtyynQTPk2euzBXgEx2CRH5ZGXZghw3I0ukOuPBOHVzsNMJjy9Jq1gHN1ZHVDMDmJEbI9R/yOiVtFOYUpwDKIFOnY3KxP2ODZwcbDG/mg0mtPDIurdP3loUxbkM9rK2GypBKviorNVrHGxjxHr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/AAZ+L3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/AAZ+L3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6a4eccab1so10745ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 16:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172767; cv=none;
        d=google.com; s=arc-20260327;
        b=F4zvun6y9M6lP3PxRrep1JjvBhzHYv8xD7V/O8wzyWqgqEXykdz0P+FWl62RxynjUH
         sfpBRDcklcjR0Thwn29K4UL4eYmzL36jUmMGVbybvd3l3hFlaPbAeU0GjDtb64FXAdCk
         A0MlMVIXmPL8uxAlJPHUA3zItyWymvXMYCM5LNzZyADm04Ael9D7/f2JF0zox/JzKHqK
         +ub9Up2G4n4ALmEg8cZM9j6BtLVufrKoEa6bspB6llYWrpNYPLEZNqTPe7Wyui8fIFbQ
         FuOcZ8s6HULN7dyCyv+fGmK/LtymwzlsahcmrewAy2FHsJFYfi91BKzuobqF81sWBfC2
         3jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UxzcRs2UWqLZ9LFgDOruDpH1+oVKLoL4iLpHMznbCgU=;
        fh=e/dZ2NKLAOWzvekJSJjQhgwsOv6SR85WpCEsC5f9rIs=;
        b=oFtvwAocqz/vZoMia8AoO1vQFTWBONHP8tQ06rK3sFKMIpKmwYGiygs50/d9mqmd4S
         00uqwIqc5P9iu8U38z3dytpHPZNdCvV/5wb0Qhlw6Kst88K8cAs33wgZvaiyn0v861PW
         2tDRBAtdL+Ts3o5RgV5szojAduagb0licVhz6hY8BS1qmUz2n+fb/HNllGyQDK7f9usW
         7eIRAbbu5PW9VclrRRk3CvXPxwQjyGmVU5hyqrOwQijw+PI1/NK609A4DL4EDTQCwY7X
         gIKdOItpXtJ4RpGl+AvfXtFh6uF1851TJkJCGJm6QmERTqO3Br3hdfk3spbw9Z+U7pho
         e/GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782172767; x=1782777567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UxzcRs2UWqLZ9LFgDOruDpH1+oVKLoL4iLpHMznbCgU=;
        b=W/AAZ+L3E5vr0+iVUYnb6X7EY6w8xS/epQUPe/uZY/J9HKDVqaootwkbfkEQKgLXyR
         zMM6e34cpwtO9G9VMCM9ozrcl1JOcLOdWlS8luX4LZPs25q/VArUWgHk5I8dSAGpp8kk
         zrxV4NhwA5TLHnGU8q20m7ldaK+E1zLs736JrlpyCJ2OqdnB7HXgl0C+GmOufcbmyw3W
         yWtAR1hFzDu7Gm+ZVzmOutLOS4UwSv9SDN6R2ahFN9nvIx2g+byW8xzLL3EMzWaJ6n3f
         3VAIT3ESysDcoVISDwkkbaV0cl1hKDQ5zmQukaacZNKzy1zAh3UkgoiQZGxlzcchwUMw
         Webw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172767; x=1782777567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxzcRs2UWqLZ9LFgDOruDpH1+oVKLoL4iLpHMznbCgU=;
        b=KyGeDMPqNTmNTQp8xL+a05DgppZpE1uNn08C9AjVanddILNOJTfN5uVt8HjFt4WoBV
         w5/8dkmS3KXIdRh1320/DDrM6527VIr9EQOFat/yKsUOUZZWSL+fLDOvqumwVP78fFCQ
         cesXlBPCIKIr8XKkeKUl1lzm1ryaW+ZsgDtosNQKmHykhRNJofCsrEWnlUmpXCq60hoy
         i348g+NmnquB5yv91bQtjE6cjiPn1eRosjoAo34Y3xzmAKqu3oniYBWSZPLDcxEytVKi
         h8la2Qi4Pla7LWs0Dcwlmq63houueJAAmDfdhBo0Faejp6WjnlCGbYr+x5BwNLkctNaI
         4ytA==
X-Forwarded-Encrypted: i=1; AHgh+RphXemfdOiMAkxK8syDkPFH+/ks9VojecAuGWDoiJZdP3tEN49GxD1uxFP8874a2RgB/q9wBVuo5eOy8JbLUhOf@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXTwp6AXh+DxXFBckV36bKdE28andoS2W2BmOkhFQJ7HBlGMc
	0TUajQ9rcKwkX3LIYYULU3h3VS8o7TmAMAbbrJpgDLIWmOGLrAAoraqPHqH/moWtPddjxGC/NqM
	DfglcHIq4RLEUBpFkIdXuKufkRT0OffYkht5d27Az
X-Gm-Gg: AfdE7cly4Gxymmc4I+ApnE2/r/wn+5PG21Cl8yE6O+kVPF/VxhoPua6G4ZPghNq1oW8
	mc7pyhDzNLsVZPcftjsSZs/+ox7O1OzNsrS2OBOn7FFZcys+p3+l0WeCEjyNOJ9xvJiZsonpMtp
	pzGMAsPPERZcuXVACh6wPOoDXY6AZ4wK3LKeW5u5XdIxJYQc+/g8cWeNKazX/pnzgWFcNeIQA62
	BPtoCyFCOdwRHmkFuKetOfvuPQmSVVKXTUtRzfGiX/mbeG3Pm3lsCuDkjVd/rOc/22+wQrUPA==
X-Received: by 2002:a17:902:c404:b0:2bf:749:55c with SMTP id
 d9443c01a7336-2c7c711c2f1mr560595ad.21.1782172766271; Mon, 22 Jun 2026
 16:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-5-irogers@google.com> <ajMhklrFodxJmb2F@google.com> <ajPxqM3s0fGP4fFi@x1>
In-Reply-To: <ajPxqM3s0fGP4fFi@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jun 2026 16:59:15 -0700
X-Gm-Features: AVVi8Ce8TowVPI5oKFqFO8vY7Sn6r8C9JA-kzz5gIevB500ckGQj4plgVl__L7A
Message-ID: <CAP-5=fVwvX01JpjJarBBYUnKwWmQ-1WKPBAj3ZDL9cwTCHvqpQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] perf tests: Add robust record retry helper and
 use subsecond workloads
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 6:25=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 17, 2026 at 03:37:06PM -0700, Namhyung Kim wrote:
> > On Tue, Jun 16, 2026 at 09:48:09AM -0700, Ian Rogers wrote:
> > > Introduce `perf_record_with_retry` and `perf_record_cleanup` in a sha=
red
> > > library `tests/shell/lib/perf_record.sh` to prevent record test failu=
res
> > > caused by transient recording or workload delays.
> > >
> > > Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
> > > `stat_all_pfm.sh` to use this robust record retry logic. These tests =
now
> > > start with very short durations (e.g. 0.01 seconds) and scale up if t=
he
> > > initial recording failed to capture samples, significantly improving =
test
> > > execution speed on success while remaining resilient to slow systems.
> > >
> > > Assisted-by: Antigravity:gemini-3.1-pro
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > @@ -60,22 +71,29 @@ test_kvm_stat() {
> > >  test_kvm_record_report() {
> > >     echo "Testing perf kvm record/report"
> > >
> > > -   echo "Recording kvm profile for pid ${qemu_pid}..."
> > > -   # Use --host to avoid needing guest symbols/mounts for this simpl=
e test
> > > -   # We just want to verify the command runs and produces data
> > > -   # We run in background and kill it because 'perf kvm record' appe=
nds options
> > > -   # after the command, which breaks 'sleep' (e.g. it gets '-e cycle=
s').
> > > -   perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > -   rec_pid=3D$!
> > > -   sleep 1
> > > -   kill -INT "${rec_pid}"
> > > -   wait "${rec_pid}" || true
> > > +   local duration
> > > +   local success=3Dfalse
> > > +   for duration in 1 2 4 8; do
> > > +           echo "Recording kvm profile for pid ${qemu_pid} (duration=
 ${duration}s)..."
> > > +           rm -f "${perfdata}" "${perfdata}".old
> > > +
> > > +           perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" =
&
> > > +           local rec_pid=3D$!
> > > +           sleep ${duration}
> > > +           kill -INT "${rec_pid}"
> > > +           wait "${rec_pid}" || true
> >
> > Can this be just like below?
> >
> >               perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" =
sleep ${duration}
>
> Right, looks equivalent and simpler,
>
> I was making notes to address the flakiness that is making me use the
> end summary of entries that fail (great feature) to run them in
> isolation to check if they work that way, which most do :-\

Here is an explanation from antigravity (sorry I have some typing
issues atm), but it comes down to how the command line is built up:

  Normally, we could just write:

    perf kvm --host record -p "qemu=E2=82=9Aid" - o"{perfdata}" sleep
${duration}

  However, on Intel x86 architectures, if no  -e  option is supplied
to  perf kvm record , it calls architecture-specific setup logic (
__kvm_add_default_arch_event_x86() ) which automatically appends  "-e"
 and  "cycles"  to the end of the  argv  array.
  Because  perf record  option parsing stops at the first non-option
(which is  "sleep" ), any arguments appended after the workload name
are forwarded directly to the workload command. This turns the
executed command into:

    sleep 1 -e cycles

  Which causes  sleep  to crash with:
   sleep: invalid option -- 'e'

I'll revise this in v4 to be clearer, but we should probably also fix
the option parsing issue.

Thanks,
Ian

> - Arnaldo
>
> >
> > Thanks,
> > Namhyung
> >
> > > +
> > > +           if [ -e "${perfdata}" ] && \
> > > +                   perf kvm -i "${perfdata}" report --stdio 2>&1 | g=
rep -q "Event count"; then
> > > +                   success=3Dtrue
> > > +                   break
> > > +           fi
> > > +           echo "No samples or report failed, retrying..."
> > > +   done
> > >
> > > -   echo "Reporting kvm profile..."
> > > -   # Check for some standard output from report
> > > -   if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Eve=
nt count"; then
> > > +   if [ "$success" =3D false ]; then
> > >             echo "Failed to report kvm profile"
> > > -           perf kvm -i "${perfdata}" report --stdio 2>&1
> > > +           perf kvm -i "${perfdata}" report --stdio 2>&1 || true
> > >             err=3D1
> > >             return
> > >     fi
