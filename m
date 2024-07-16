Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114617C9E7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133012; cv=none; b=PRmDY0f3flFernEliVxt2ajtM9qofgoDnk/zLgeciGtEfG1P465x4cIMOuzkyrgdPu49Wx7ji1SqJtdVaMmPd4F8xCssFOS270824OSI/0nMle+ZDHVYlzMO+t3geaRUpiV5zlUNJVIk3WbaabAhspe1WwJGxHHYFeysse8rlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133012; c=relaxed/simple;
	bh=AbsEBBewkqsNxWGR/pFu5rJgrwmNll0Suj1ejv1utxw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z9gVE83onKcecQsdWaUgi1KIoHnu/TkR89hTl+2Sa2psuB3NpBiMD4bj8DxzkX7OCNw0BHttfC8cc/TAf7nSC0fEG8iv3D/HYyhfC1s3VyYb3T9UZ+fwC4o4jGl1noPHtNPZKUpxQ+srbm4HrxdVey8xy1thPNS4uoCyrnp5HZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P190drxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P190drxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721133009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnjDZAq6VcVuBjhdts63heqZZTvBQisTpXSxqHi1GLo=;
	b=P190drxuucpbhZ/PCm8cZ07HuZb/4fhm5Fo+NdfDpCQtQDjIIL3hnBYFqgXhuOOcmivXd4
	jRCyXAnjnx20d1CcUNUcK1zxQl2KtVFSh66KWn05Rk+YVq6WdytYhgev7ikfO9ETFzbMOL
	6DiIAz/w0LWSSAmxJkWCTBURO8WxUBU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-djY3kHWFMcu6vxXEiiME_A-1; Tue,
 16 Jul 2024 08:30:06 -0400
X-MC-Unique: djY3kHWFMcu6vxXEiiME_A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF8561955D52;
	Tue, 16 Jul 2024 12:30:03 +0000 (UTC)
Received: from Diego (unknown [10.39.208.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CE5B19560B2;
	Tue, 16 Jul 2024 12:29:53 +0000 (UTC)
Date: Tue, 16 Jul 2024 14:29:49 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: royenheart <royenheart@gmail.com>
cc: Namhyung Kim <namhyung@kernel.org>, vmolnaro@redhat.com, 
    peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
    mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
    irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH 1/1] perf archive: unpack to correct dir given by perf
In-Reply-To: <f7d246d4-edae-4b4c-8b19-ad6fa66e8ea1@gmail.com>
Message-ID: <alpine.LRH.2.20.2407161424070.11376@Diego>
References: <cover.1720372219.git.royenheart@gmail.com> <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com> <ZpCyf6ulH-8dRBu4@google.com> <f7d246d4-edae-4b4c-8b19-ad6fa66e8ea1@gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 16 Jul 2024, royenheart wrote:
> On 2024/7/12 12:35, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Jul 08, 2024 at 02:04:31AM +0800, Haoze Xie wrote:
> >> In perf-archive.sh, the code segment that defines 'PERF_BUILDID_DIR' is
> >> advanced before 'unpack' operation for subsequent use, followed by a
> >> 'mkdir' operation to ensure that the dir exists. Symbols in 'unpack' will
> >> be extracted to correct dir given by perf.
> >>
> >> When '--unpack' param is appointed, the symbols are extracted to '~/.debug'
> >> folder by default, without using 'PERF_BUILDID_DIR' given by perf. This
> >> will cause perf to be unable to find the correct buildid's path when users
> >> configured buildid.dir in 'perf config' or used '--buildid-dir' cli param,
> >> since perf will read these params and put them in 'PERF_BUILDID_DIR' env.
> >> 'perf script' and 'perf report' will use the env as the basis for buildid
> >> indexing.
> > 
> > Can you please add an example command line and the output for the error
> > case?  It'd be helpful to understand the problem more intuitively.
> > 
> >>

[...]

> 
> I have two machines A and B, I use 'perf record' and 'perf archive' to get
> a buildid archive 'perf.data.tar.bz2' on A: 
> 
> $ perf record -a -g -- sleep 1
> $ perf archive
> 
> then I transfer 'perf.data' and its buildid archive to B. On machine B, I
> use 'perf archive' to extract the buildid:
> 
> $ perf archive --unpack
> $   Found target file for unpacking: ./perf.data.tar.bz2
> $   .build-id/d1/a727ab038085dbbb50e74c812e5a6e8502e8c7
> $   ...
> 
> But when I use 'perf script' to view hotspots, no function names are shown:
> 
> $ perf script
> $   No kallsyms or vmlinux with build-id 
> $   251c1248b97a17df394058a189dffe381169ddcd was found
> $   perf    1770 [000] 1022235.467607:          1 cycles:P: 
> $           ffffffff8ae9ceb6 [unknown] ([kernel.kallsyms])
> $           ffffffff8ae15af5 [unknown] ([kernel.kallsyms])
> $           ffffffff8ae0f83b [unknown] ([kernel.kallsyms])
> $   ......
> 
> The problem is, I used 'perf config' to change buildid search path before:
> 
> $ perf config --user buildid.dir=/usr/local/symbols
> $ cat ~/.perfconfig
> $   # this file is auto-generated.
> $   [buildid]
> $           dir = /usr/local/symbols
> 

Shouldn't then perf-archive just determine the directory from perf-config
without any additional env var?

> But 'perf archive --unpack' just extract them to '~/.debug', which makes
> perf can't found right path to search for buildid info. If I add
> 'buildid-dir' param to replace buildid path defined in perfconfig, problem
> can be solved temporarily:
> 
> $ ./perf --buildid-dir ~/.debug script
> $   perf    1770 [000] 1022235.467607:          1 cycles:P: 
> $           ffffffff8ae9ceb6 native_write_msr+0x6 ([kernel.kallsyms])
> $           ffffffff8ae15af5 intel_pmu_enable_all+0x15 ([kernel.kallsyms])
> $           ffffffff8ae0f83b x86_pmu_enable+0x1ab ([kernel.kallsyms])
> 
> The code that determines the buildid path is in the 
> 'util/config.c:set_buildid_dir' function, which will generate
> 'PERF_BUILDID_DIR' var.

As above, the var seems to be a duplicate to what is already stored in
perf-config...

> 
> 

Regards,
Michael

