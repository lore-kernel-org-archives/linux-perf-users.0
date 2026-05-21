Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077203ED5C8;
	Thu, 21 May 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369183; cv=none; b=V4a8Q0uPvvt0cXDuI2K0DnU6t6YJwJrATG4pC0r4nbdrpNoKPMuGTyJQk3zYYtJf2IJs3SAuy1TiQOY92ht2JAkV4rFzvG7KBKrlTUFXQjf3/QX5e1qp49uSFz3W1XE8p6wsEZygt3EHUWr33B3ErDScWeXupOfaupNUI+T/y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369183; c=relaxed/simple;
	bh=RloxjqNJqqX5DQ4NmwEkbaubbhwMFlN2OV2Wu1P9huk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N27IOSz18JaP+v7n7QipUxeQiiN+4yl8LoLvYYu3fUU4rx8V/h/8AuNSQBb5aTAefCNjZSy+L0RlDo1XXgb18D8PixR8hbE8oMeoosCBUL8ABxKV5xwUHwS5ka6C6Kap3fHtn5FaS64xzggaCy4WNnOwqwANWx/iXqY8OYXAPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecvO21fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecvO21fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1281F00A3B;
	Thu, 21 May 2026 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369181;
	bh=XeVPV9xj5x5iIWCFWISFapbQ/GVk06WkwpCwBrOQ+hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ecvO21frwFulf3NBcA+R69+Gd1/poIBiojh8dX74sXxPeGfKG9AEcOKal9htzSZtG
	 q1AdIGk97RpDzBmdEZQvRu7BXr6zNQ8oMuZ7k3diy5YLP0CvDsGRZDdKMhjjHgo7z4
	 MGRgKUSEh5J26CBIfsDUtAug6sl6GmHMy2khuLZLDC7/vZQ3hyfZe4fS3Tl4r6RWGL
	 CTlafXgX3ipK11L6HdqK/1mZDhy8QayuYK6b9skLy2453u0oidt9/62ToMUj+eUXS/
	 y3vWrbyfhojl2cZRxQsLh9HhD8VpdLYMVMWIKFJK8phQC/swGu4faf27NZQuWfwQ1E
	 w9LrbtHvgifdg==
Date: Thu, 21 May 2026 10:12:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag8E2qiJNwatvIPL@x1>
References: <ag4e1BNQlZWVWISE@x1>
 <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1>
 <ag4kauWBogiPBhRh@x1>
 <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
 <ag4l42A5UJOR3tQz@x1>
 <ag4szmCZdWwqHR_R@x1>
 <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>
 <CAP-5=fX5Tm8Hikaba63QHbWDsfZ6=cQc2tq1=F4Xbxgjb7y42A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX5Tm8Hikaba63QHbWDsfZ6=cQc2tq1=F4Xbxgjb7y42A@mail.gmail.com>

On Wed, May 20, 2026 at 03:43:52PM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 3:32 PM Ian Rogers <irogers@google.com> wrote:
> > I'll look at the perf-data-validation branch. Would it be okay to post
> > the patches to LKML so that we can get the Sashiko review on them?
 
> In "perf session: Bound nr_cpus_avail and validate sample CPU" the
> perf_session__deliver_event change appears to inline
> evlist__parse_sample which seems unfortunate from a code reuse
> point-of-view. The commit message calls this out but doesn't describe
> the motivation for the change. Could we fix evlist__parse_sample?

The motivation:

      18 -Also refactor the sample parsing in perf_session__deliver_event()
      19 -to call evsel__parse_sample() directly (via evlist__event2evsel()
      20 -for evsel lookup), with explicit guest VM SID resolution for
      21 -machine_pid and vcpu fields.
      18 +Inline evlist__parse_sample() into perf_session__deliver_event()
      19 +so the evsel lookup needed for sample_type checking reuses the same
      20 +evsel that parsed the sample, avoiding a second evlist__event2evsel()
      21 +call on every event.

A follow up patch could introduce a evlist__parse_sample variation that
passes a evsel pointer address where to store the evsel used so that it
can be reused and avoid the duplicate lookup.

- Arnaldo
