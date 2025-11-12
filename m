Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4359331A73
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951483; cv=none; b=mQl+GJjSbcEbN5IVl04pwz7haT73f9Fk0XbHG84bybgJWsSnomk7n8HF+VG1NOBNbZCqy7l1cr5P4TflYiPfOv+80zu0V0kLnkZOhIH8/q25RUUNvuWbnZjtvdgMgjoSbZygz4sVL4VZB4GAK2rheFm6qIT3B5iYY8Yy8OVgx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951483; c=relaxed/simple;
	bh=567v1ntpe0vRcrzqlYLmwNeEdmxGAXaWmaKfegiR7RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqJJyLD2o6BzWvSnlWMG16tp8BmsryDdrIMj3QEiMOsugyHnoK/pXKPUzyJ4iq76Qn9pug6pGiuN66XUDBZ8EPA1q4sa76IZJiBLM1TJp8kSZOSYKjsCa5+H8TMiLy53Oh/ho2ZoyLqUTZ/CbgnMlWeuvhlhO2/yZ3BHsQ6ZIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/NSnBp5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/NSnBp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762951480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUViZBQiyYPpr7WESLgYWJ53oA+Voehw73EV9RI/kMQ=;
	b=W/NSnBp5jz+QzR5xDRLMETv5UL3gm0/zvsGjH8PQeKY9k5VzkjtHnqp8aiTYNdDBjdHX7V
	aPgqSvm6y7Tz0cGSOoGZ6jgR/+FiBKCObT9P6C9/c56dTGjD1oHcvEiojbz3VWBvQbO8uW
	qNQsXEQWT+TWVF+m7Zz+BtxhqkiaUgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-ZBjBsd8UOUmvAzhkXwpbOA-1; Wed,
 12 Nov 2025 07:44:39 -0500
X-MC-Unique: ZBjBsd8UOUmvAzhkXwpbOA-1
X-Mimecast-MFC-AGG-ID: ZBjBsd8UOUmvAzhkXwpbOA_1762951478
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4797E1956096;
	Wed, 12 Nov 2025 12:44:38 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.csb (unknown [10.44.32.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74AE130044E6;
	Wed, 12 Nov 2025 12:44:35 +0000 (UTC)
Date: Wed, 12 Nov 2025 13:44:31 +0100
From: Jakub Brnak <jbrnak@redhat.com>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com,
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: Re: [PATCH v4 5/7] perf test: Introduce storing logs for shell tests
Message-ID: <aRR788vna0u-CEUU@jbrnak-thinkpadx1carbongen9.tpbc.csb>
References: <20250930160923.13728-1-jbrnak@redhat.com>
 <20250930160923.13728-6-jbrnak@redhat.com>
 <CAP-5=fUJZEoAbNu+ZzjgshHRbq94dLn6-KPdzC=i9i350K=4dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUJZEoAbNu+ZzjgshHRbq94dLn6-KPdzC=i9i350K=4dw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 30, 2025 at 12:00:19PM -0700, Ian Rogers wrote:
> On Tue, Sep 30, 2025 at 9:09 AM Jakub Brnak <jbrnak@redhat.com> wrote:
> >
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> >
> > Create temporary directories for storing log files for shell tests
> > that could help while debugging. The log files are necessary for
> > perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
> > is set keep the logs, else delete them.
> 
> I think log files for tests are a good idea. We run tests in parallel
> but read the stdout/stderr sequentially. For a failing test we may
> fail to read stdout/stderr in some situations as the process has long
> since died. Rather than add log files specifically for shell tests
> perhaps update start_test to pass the file descriptors to the child
> test processes and then clean up in finish_test?
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/builtin-test.c?h=perf-tools-next#n528
> 
> Thanks,
> Ian

Hi Ian, 

Thanks for the feedback.

You've raised a good point about capturing stdout/stderr for parallel runs,
but this patch is solving a different problem.

The logs we're storing here are test-generated data artifacts, not the
stdout/stderr of the test process itself.

Our patch provides a $PERFSUITE_RUN_DIR environment variable so that commands inside the shell script (e.g., perf record)
have a known directory to save these files for debugging.

Thanks,
Jakub

