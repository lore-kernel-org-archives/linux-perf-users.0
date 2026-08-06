Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCE1A682C;
	Thu,  6 Aug 2026 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994844; cv=none; b=qb2SdXlIWiXnL0UJAr+TJsublvOKR8DrmnNGJpT0s5aERuluekdrJAG9p5MiGLrLnF15SPW5CG5O5YJuCvTh0k3XWGZt6bKhk82snAUanKZNcdS1YGSC6CGpviuTyeCCZYxs7D1nj3suwermE8qKPu0jFN0DHY6NCXmk7QQmops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994844; c=relaxed/simple;
	bh=WADd6vGeeU9OJNepBvcH1C6UnYUHjrAY//NLC6sgTTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT2yAFkrqalQqLm5smd/L/C3365Jn+TDZynWmnXeUTckA3m6xUxtKn5Ym/vgw56IDfGZvQ8mH1MuTjJigNwLOjwcUI1kEf/gn0HdqYakccg3eN13KXNmDxBBvLOlTTLcke6jIVX5orfMnwpSJ+3XsBXcQIucX9uI+IqLuv/5ys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrLFpZMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrLFpZMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB291F000E9;
	Thu,  6 Aug 2026 05:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785994842;
	bh=cFWJ5mmV9ugae6Hj18D13lBKr5wTHjHe+Y+Htr9wxws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrLFpZMM0el2EkDV0KE/i4gDrgYKwgVwYjnNIe+oHbhDE7HO3F7lF4WYqospuAgeS
	 AblODgZnk0NKWOrVCkE9rFUQ/m2WZiin0/UF48zoOIfCZ6aqz2ng9bhFpdtk7jk/mU
	 EH8SvDw/+cRRJ1LjdaxG16QBDY3KtVkgNatXCJa9VWstdSU/01oQNrBYp9vt3tyVQL
	 SCgwx67PICU1ef6Yy4giJkfGv3nxhJC0jFZN5RatNNnG0kthAaeMlqK6+1Ex4FEUXu
	 vjgfwt8DFbdQRXpxAVKckcWM14cZK0mkfEXt8bDmNvxZ5SvVODlj+uK4ViTH6EhaLl
	 BH/Y0JOt0VP8w==
Date: Wed, 5 Aug 2026 22:40:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: PVS Narasimha Rao <venkatasuryapala@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP
 values without LOST
Message-ID: <anQeWZD8J-gHMt_3@google.com>
References: <20260725084704.15463-1-venkatasuryapala@gmail.com>
 <20260725085651.648B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725085651.648B11F00A3A@smtp.kernel.org>

Hello,

On Sat, Jul 25, 2026 at 08:56:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The test setup for grouped reads without PERF_FORMAT_LOST validates garbage data because it provides a standard C array of structs rather than a tightly packed buffer.
> --
> 
> --- Patch [1]: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST ---
> commit 803c0b64d4e8c311df29991bbbdd74726b85a1dd
> Author: PVS Narasimha Rao <venkatasuryapala@gmail.com>
> 
> perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST
> 
> This patch updates the sample parsing test to validate the value and id
> fields in grouped reads even when PERF_FORMAT_LOST is absent. It uses
> next_sample_read_value() to properly navigate the variable-sized group
> entries during validation.
> 
> > diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> > index 55f0b73ca20e0..e44b01e5cd14c 100644
> > --- a/tools/perf/tests/sample-parsing.c
> > +++ b/tools/perf/tests/sample-parsing.c
> [ ... ]
> > @@ -86,10 +86,27 @@ static bool samples_same(struct perf_sample *s1,
> >  			COMP(read.time_running);
> >  		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
> >  		if (read_format & PERF_FORMAT_GROUP) {
> > +			struct sample_read_value *v1 = s1->read.group.values;
> > +			struct sample_read_value *v2 = s2->read.group.values;
> > +
> >  			for (i = 0; i < s1->read.group.nr; i++) {
> > -				/* FIXME: check values without LOST */
> > -				if (read_format & PERF_FORMAT_LOST)
> > -					MCOMP(read.group.values[i]);
> > +				if (v1->value != v2->value) {
> > +					pr_debug("Samples differ at 'read.group.values[].value'\n");
> > +					return false;
> > +				}
> > +
> > +				if (v1->id != v2->id) {
> > +					pr_debug("Samples differ at 'read.group.values[].id'\n");
> > +					return false;
> > +				}
> > +
> > +				if (read_format & PERF_FORMAT_LOST &&
> > +				    v1->lost != v2->lost) {
> > +					pr_debug("Samples differ at 'read.group.values[].lost'\n");
> > +					return false;
> > +				}
> > +				v1 = next_sample_read_value(v1, read_format);
> > +				v2 = next_sample_read_value(v2, read_format);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does using next_sample_read_value() here
> inadvertently cause the test to assert equality on misaligned garbage data
> when PERF_FORMAT_LOST is omitted?
> 
> Looking at do_test(), the original sample is initialized with a standard C
> array of struct sample_read_value:
> 
> tools/perf/tests/sample-parsing.c:do_test() {
>     ...
>     struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
>     ...
>     if (read_format & PERF_FORMAT_GROUP) {
>         sample.read.group.nr     = 4;
>         sample.read.group.values = values;
>     }
>     ...
> }
> 
> Since this array always has a 24-byte stride, but next_sample_read_value()
> advances by a 16-byte stride when PERF_FORMAT_LOST is absent, both the
> synthesizer and this validation loop end up reading overlapping memory
> instead of the actual struct fields.
> 
> Could the test setup be updated to provide a tightly packed buffer so that
> we validate the actual fields rather than falsely passing on identical
> misaligned reads?

I think it's a valid issue and it seems there's a bug in the
perf_event__synthesize_sample().  The input values contain the lost
field regardless of the read format.  So it should skip the field
carefully.

Thanks,
Namhyung

