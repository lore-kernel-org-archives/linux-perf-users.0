Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEF5645F
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602331; cv=none; b=NfwvxhKH+bHXWybcuEGisCl2TNfgzBID6k8PPVJnJ0zN6bfMIQXMru62/ejtg+NARCqYG9hFMqfo0KFjoSSuMNY5eCW2rowyM+jqpLzROyxtI3MCwn4LE1LYy4QZ5S913cbcLOm1QgkQjah/JXWUY0EgpiW1HmMrr5k3xnft8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602331; c=relaxed/simple;
	bh=FQqk5bgIymA2h3AOp2AOhLuIZ5Mr2uKbmZHieP9quSE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=lZXJiC+kEgECZJlHCt/Hx/IwFfMv5fYrw/ZEBXmBMhcY6pIrs5mI7vt8oI5R9n+31CwMcAsrf7rxqg/ha4NNEEOUYyVaMvM9cCCP2ChGxZFtyffhNVFkhjHdPWbqF2uvmPHGYfQTv60AxZxVfZR3TkxhvqpGa87s556OHy+rHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsj3GZff; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsj3GZff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706602328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dztU367JQMlugGJ2nAxDmIAtTR/QV+FtA1cZNHkVWn4=;
	b=gsj3GZff9HlJ2WjSFXaUtqrJvDEKIWrCZj7hvT+N99OVWUfHjcxf2zjgeCixsjL3O0H6oT
	k+9cGZW03hrbT0ePGOY37i3dkn0f2frF2+VCI6Hnx6SuWHLZ/W15rq4MfLXVVMdBXzf9WP
	qYClpoNyEiqOhtBmY9Se/ysUmjBd+sA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-1GVXa2T9O6-5xe2L0Z89JQ-1; Tue, 30 Jan 2024 03:12:04 -0500
X-MC-Unique: 1GVXa2T9O6-5xe2L0Z89JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 001C2837227;
	Tue, 30 Jan 2024 08:12:04 +0000 (UTC)
Received: from Diego (unknown [10.39.208.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5588B;
	Tue, 30 Jan 2024 08:12:01 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:11:59 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: irogers@google.com
cc: vmolnaro@redhat.com, edward.baker@intel.com, perry.taylor@intel.com, 
    samantha.alt@intel.com, weilin.wang@intel.com, acme@kernel.org, 
    alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com, 
    zhengjun.xing@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Intel Sapphire Rapids uncore: umask too big
Message-ID: <alpine.LRH.2.20.2401300733310.11354@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello Ian and others,

we have encountered some issues with uncore events on Sapphire Rapids. There are
a couple types of problems. One of them is the following:

    # perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls 
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ Bad event or PMU
    
    Unable to find PMU or event on a PMU of 'uncore_cha_55'
    
    Initial error:
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ value too big for format, maximum is 4294967295
    Run 'perf list' for a list of valid events

There is a 34bit umask that can handle it, namely umask_ext2, but it is not
used for sapphire rapids:

uncore_snbep.c:5958:static struct attribute *spr_uncore_cha_formats_attr[] = {
uncore_snbep.c-5959-    &format_attr_event.attr,
uncore_snbep.c-5960-    &format_attr_umask_ext4.attr,
uncore_snbep.c-5961-    &format_attr_tid_en2.attr,
uncore_snbep.c-5962-    &format_attr_edge.attr,
uncore_snbep.c-5963-    &format_attr_inv.attr,
uncore_snbep.c-5964-    &format_attr_thresh8.attr,
uncore_snbep.c-5965-    &format_attr_filter_tid5.attr,
uncore_snbep.c-5966-    NULL,
uncore_snbep.c-5967-};

(I see umask_ext4 there and means 32bit:
uncore_snbep.c:479:DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
)

What is wrong? The json files specifying umask=0x10c0008101 for the event,
or the structure that should rather support umask_ext2 ?

There are a few more issues, I will update when analyzing them deeper.

Thanks.
Michael

