Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3626FA70
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318364; cv=none; b=iPAP5ZkSbc6dZNqaboEN7xuG7Rw2O4D5D7hRPhkvfvyGqGw89f7bY9qpaB/Kpkjttdsi3hD85ouaygvTKPhVth6CUSkqbFP2DupUB0vN2Yu7CsHBhTUJ6kYtOu6qmDokDcy3SsyeOXuOENEeFQYz39+kzmEAKtmfYHk8Dch1LuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318364; c=relaxed/simple;
	bh=3fz6+8P8bw3IVLSdFvddIfC8vzwRTDa8ht8hWdsbcPQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aOunHn6WVL4YnED5z9P2perRqQj7FreW13hnbOO6awV3MlQpU4YwjsbJ+WnBo9BgYEKZSWUmymRGiUXhAJM5JvzwLiGmXyazz2jdvg3D+ElBKksMonNMKx4HHdVHO/qOgfVgW+ghNkMtbVcae2bqsUzc+uoPLiGe7egmlI2n+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UseUQXgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UseUQXgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754318361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QajdySu+WaIEXmBw3FF5tBK7+cj/V8bA9alz7LyGQoA=;
	b=UseUQXggv6+m+mqtSfmjbZyPa0Cl7ZN90uKDi1CwHqM56CyZZbnDNgJRm2vLYhGhSoT6xZ
	XyASnC+f2ggVvSWM37S7sdJSMN+NkZjD9mut/6qeyimay//Wf7MDCpwrMPu+DFqTBaFENl
	bZrkMS1mVhmOulf926qawkTiidZOQ9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-qVsS676mNwqtcyx52mJB2g-1; Mon,
 04 Aug 2025 10:39:18 -0400
X-MC-Unique: qVsS676mNwqtcyx52mJB2g-1
X-Mimecast-MFC-AGG-ID: qVsS676mNwqtcyx52mJB2g_1754318357
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD81196E073;
	Mon,  4 Aug 2025 14:39:17 +0000 (UTC)
Received: from Carbon (unknown [10.45.242.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D79921800EEC;
	Mon,  4 Aug 2025 14:39:12 +0000 (UTC)
Date: Mon, 4 Aug 2025 16:39:07 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
cc: Jakub Brnak <jbrnak@redhat.com>, vmolnaro@redhat.com, acme@kernel.org, 
    acme@redhat.com, irogers@google.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/7] perf test: Provide setup for the shell test
 suite
In-Reply-To: <aIRwscmIfCHQkeVS@google.com>
Message-ID: <fc7a28-97bb-a91f-6239-39973b94e2e0@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com> <20250721132642.40906-1-jbrnak@redhat.com> <20250721132642.40906-4-jbrnak@redhat.com> <aIRwscmIfCHQkeVS@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, 25 Jul 2025, Namhyung Kim wrote:
> On Mon, Jul 21, 2025 at 03:26:38PM +0200, Jakub Brnak wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Some of the perftool-testsuite test cases require a setup to be done
> > beforehand as may be recording data, setting up cache or restoring sample
> > rate. The setup file also provides the possibility to set the name of
> > the test suite, if the name of the directory is not good enough.
> > 
> > Check for the existence of the "setup.sh" script for the shell test
> > suites and run it before the any of the test cases. If the setup fails,
> > skip all of the test cases of the test suite as the setup may be
> > required for the result to be valid.
> 
> Looks like better to be documented somewhere.  Maybe you can add a
> section like "Add a new (shell) test" in the perf-test man page or so.
> 
> Thanks,
> Namhyung
> 
This is indeed a great idea! It could help the future testcases align
with what we have. Currently the tests handle temporary files, logs
and debugging output on their own. Unifying this, all the tests would
then keep/delete logs based on the same env. variable. Let's follow up
this patchset with providing such docs.

Regards,
Michael

