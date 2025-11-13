Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340472E9749
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046714; cv=none; b=BDXu+kuWtEG7pFuiorBhSaf4/hpq8gGTKJxeWmySscXasWsY1bhSKPgk4BOQ1x/qKuxC8Z/Li6vbLWwmMtp7tNULXzFmrzcD622kjTJKWY1GaNLqnyCzpgNRQc7cj/eCk1rkLq3oa7mFw8vmTaqTR/jHH2iVXyCufszySFMnt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046714; c=relaxed/simple;
	bh=PjTYtuAvYqH0+3B7Pow+sBOvhgLLJ1RhoDkzltZbDJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbF6vr4uc+yhGH5kFrJc71Yi8aGGK/xUJKhhOdYZHwGFInt5880oQ/dKqePoDkI1ufLVRbPmdGQvRuAVmh+DdeaVsiZIlXGNGncyu3LN92beMgPlbi/4DQWrl9XUIv6H5HvwCoM6gHt1vRBz9n9azF+KRysMhTv0uSK6a7Ig5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imX+7Efm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imX+7Efm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763046711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGwjSejoi/FNrRgxNYTTmwSshKg7lU07+d+y7DlskH8=;
	b=imX+7EfmkGJD8e4kL1hGnxmqANnavp0Gh6OyxnNC5nF2EZdJN4qjvnPA4p7Ef+FxMpdgi2
	8RW6TNDHxYEpKiuIkQcxD57lMMrV8qjgmbgrJqNvcGIsFOs9ZXafEb90xPFxylXsGt2fpw
	hEYtQs1/HEf5iomKLWu6MPImB1uwHbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-x1VYgh3MNzm_08JUPF98jA-1; Thu,
 13 Nov 2025 10:11:50 -0500
X-MC-Unique: x1VYgh3MNzm_08JUPF98jA-1
X-Mimecast-MFC-AGG-ID: x1VYgh3MNzm_08JUPF98jA_1763046708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5759218002C3;
	Thu, 13 Nov 2025 15:11:48 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.csb (unknown [10.43.17.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3812300018D;
	Thu, 13 Nov 2025 15:11:45 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:11:42 +0100
From: Jakub Brnak <jbrnak@redhat.com>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com,
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: Re: [PATCH v4 5/7] perf test: Introduce storing logs for shell tests
Message-ID: <aRX1Lst9-H7hFjTf@jbrnak-thinkpadx1carbongen9.tpbc.csb>
References: <20250930160923.13728-1-jbrnak@redhat.com>
 <20250930160923.13728-6-jbrnak@redhat.com>
 <CAP-5=fUJZEoAbNu+ZzjgshHRbq94dLn6-KPdzC=i9i350K=4dw@mail.gmail.com>
 <aRR788vna0u-CEUU@jbrnak-thinkpadx1carbongen9.tpbc.csb>
 <CAP-5=fWvSVswOwxjQmiDsSmvkD0HdVwPgXWib4zg=SQFyRfTUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWvSVswOwxjQmiDsSmvkD0HdVwPgXWib4zg=SQFyRfTUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 12, 2025 at 08:37:03AM -0800, Ian Rogers wrote:
> On Wed, Nov 12, 2025 at 4:44 AM Jakub Brnak <jbrnak@redhat.com> wrote:
> >
> > On Tue, Sep 30, 2025 at 12:00:19PM -0700, Ian Rogers wrote:
> > > On Tue, Sep 30, 2025 at 9:09 AM Jakub Brnak <jbrnak@redhat.com> wrote:
> > > >
> > > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > >
> > > > Create temporary directories for storing log files for shell tests
> > > > that could help while debugging. The log files are necessary for
> > > > perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
> > > > is set keep the logs, else delete them.
> > >
> > > I think log files for tests are a good idea. We run tests in parallel
> > > but read the stdout/stderr sequentially. For a failing test we may
> > > fail to read stdout/stderr in some situations as the process has long
> > > since died. Rather than add log files specifically for shell tests
> > > perhaps update start_test to pass the file descriptors to the child
> > > test processes and then clean up in finish_test?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/builtin-test.c?h=perf-tools-next#n528
> > >
> > > Thanks,
> > > Ian
> >
> > Hi Ian,
> >
> > Thanks for the feedback.
> >
> > You've raised a good point about capturing stdout/stderr for parallel runs,
> > but this patch is solving a different problem.
> >
> > The logs we're storing here are test-generated data artifacts, not the
> > stdout/stderr of the test process itself.
> >
> > Our patch provides a $PERFSUITE_RUN_DIR environment variable so that commands inside the shell script (e.g., perf record)
> > have a known directory to save these files for debugging.
> 
> Sgtm. Is there anyway this can be a common feature with kunit testing?
> It'd be nice to have a similar strategy in the perf tests and kunit,
> for consistency across the code base.
> 
> Thanks,
> Ian

Hi Ian,
good point on consistency but KUnit reports pass/fail text from kernel. These perf tests are 
user-space scripts that test commands which generate data artifacts (like perf.data), not just text results. 

A common strategy for KUnit's text-based status reports versus perf's data 
file artifacts doesn't seem to fit naturally.

This patch is primarily a hook to support upstreaming the perftool-testsuite, which relies 
on this directory ($PERFSUITE_RUN_DIR) for its artifact-based debugging. Given it's a 
different testing model, we feel this approach is appropriate here.

Thanks,
Jakub

