Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762414EC47
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578751; cv=none; b=XVh4M4fy9o3JnKv9dPHNsLKhKMgZDZhJGKNiKNvuGe2S2ZmKQVmOqf5Hr4rBr6lHwvjLos0PVdhXcBA2kB8rCjZhfZWPcBVeLUFWfjxrMQsxmTCNHuO1Nh+1+WOgQ6PVX/cPHNxbQ4mNB/GEKXN80AFFTzPzIZC84mPkiv9Yk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578751; c=relaxed/simple;
	bh=FgiEHCoQJ7ShE2yWB2ERyRL589Yo2BSrEg7bSboynBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gf7YzI0j27eGKXBfd4HDuef5mHARpa7L4Ozm7gO1MvpE9wz1AqYbC/9cdHAQ0wP41n3WH86wZkW9PB20wNg8Sl8BPsJuVU3Uqyw+LvC0bKnXR/HSv7hT8TGFY9VyAga4wwAsBqEHWKoUOGvPR1vlGq2du7m8ZNpdBJmEFKX3qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiJGOT4i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiJGOT4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731578748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Aczb8xlsdyYMxnrkmwTQQ3EUumWpfFrMZHGUDqIlVk=;
	b=MiJGOT4ipNB9mMbTBokUbST/dV41LJzT6nHbn3l53kAK+Ke8p0lZ8uouFPOtU23ZQ4mEt0
	krs83198D8gjJ9MjwSxWSoYfmRql0qdIP0zV4dH6xqX6Fx9+ECRO6hX/zLa7RJ8n+JvjhZ
	kBgdhklBlhmQooSr1oRzlgxfFsACOX4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-WNfiqp02OVqwPwjSVYwiGg-1; Thu,
 14 Nov 2024 05:05:45 -0500
X-MC-Unique: WNfiqp02OVqwPwjSVYwiGg-1
X-Mimecast-MFC-AGG-ID: WNfiqp02OVqwPwjSVYwiGg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F49195395A;
	Thu, 14 Nov 2024 10:05:43 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CE6019560A3;
	Thu, 14 Nov 2024 10:05:38 +0000 (UTC)
Date: Thu, 14 Nov 2024 11:05:34 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
    irogers@google.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
    kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests/base_probe: Fix check for the count of
 existing probes in test_adding_kernel
In-Reply-To: <0FEA83FD-BBC9-4E83-82D6-044141E86F76@linux.vnet.ibm.com>
Message-ID: <1da9544-1e17-3830-49f9-6a6d78439e71@redhat.com>
References: <20241014153910.85536-1-atrajeev@linux.vnet.ibm.com> <941c3d6a-fc2-3fcf-5ab2-597dcf712c16@redhat.com> <0FEA83FD-BBC9-4E83-82D6-044141E86F76@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463776256-1326094925-1731578743=:9263"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463776256-1326094925-1731578743=:9263
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 3 Nov 2024, Athira Rajeev wrote:
> > On 17 Oct 2024, at 3:44 PM, Michael Petlan <mpetlan@redhat.com> wrote:
> > 
> > On Mon, 14 Oct 2024, Athira Rajeev wrote:
[...]
> > 
> > I am wondering how it could happen that there were other
> > probes in the system?
> 
> Hi Michael,
>
Hello Athira.

> Sorry for the late response.
> 
> Yes, there are uprobes listed as part of “perf probe” in the environment where I saw the test needing this change. Sharing the result below from perf probe: 
> 
> # ./perf probe -l
>   uprobes:p_uprobe_dns_events_osquery4026531841 (on getaddrinfo in XX)
>   uprobes:p_uprobe_dns_events_osquery4026532336 (on 0x129a60 in XX)
>   uprobes:p_uprobe_dns_events_osquery4026532344 (on 0x129a60 in XX)
>   uprobes:p_uprobe_ebpf_compat_check_osquery (on __GI___backtrace in XX)
>   uprobes:p_uprobe_sys_hook_osquery (on backtrace_symbols in XX)
> 
> These can’t be removed.
> 
> # ./perf probe -d uprobes:p_uprobe_dns_events_osquery4026531841
> Removed event: uprobes:p_uprobe_dns_events_osquery4026531841
> Failed to delete event: Device or resource busy
>   Error: Failed to delete events.
>

Ah, this is interesting, I have never hit that. However, it makes sense,
if the resource is busy.

However, in that case it comes to my mind that in general, these tests
should not be run in any production environment, where one could rely on
some probes will exist, etc. In case some of the probes above was not
busy, it'd be probably cleaned up by the testcase, which might be unexpected
by the creator/user of the uprobes... Maybe we should get rid of the
probe cleaning for that cases, but I'd prefer to keep it.

> Considering above scenario, patch here takes the probe count using:
> NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> 
> Also similarly looks for TEST_PROBE in result log in case of probe —del as well
> 
> Any comments Michael ?
>
Yes, we probably should tweak it as you suggest.

Thanks,
Michael


> Thanks
> Athira
> 
> > 
> > Cheers,
> > 
> > Michael
> > 
> >> 
> >> Example, in the system where this failed, already some
> >> probes were default added. So count became 10
> >>  ./perf probe -l | wc -l
> >>  10
> >> 
> >> So to be specific for "inode_permission", restrict the
> >> probe count check to that probe point alone using :
> >> NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> >> 
> >> Similarly while removing the probe using "probe --del *",
> >> ( removing all probes ), check uses:
> >> 
> >> ../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE"
> >> 
> >> But if there are other probes in the system, the log will
> >> contain reference to other existing probe too. Hence change
> >> usage of check_all_lines_matched.pl to check_all_patterns_found.pl
> >> This will make sure expecting string comes in the result
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> index d541ffd44a93..f8b5f096d0d7 100755
> >> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> >> @@ -169,7 +169,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second pr
> >> (( TEST_RESULT += $? ))
> >> 
> >> # adding existing probe with '--force' should pass
> >> -NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`
> >> +NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> >> $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
> >> PERF_EXIT_CODE=$?
> >> 
> >> @@ -205,7 +205,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
> >> $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
> >> PERF_EXIT_CODE=$?
> >> 
> >> -../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
> >> +../common/check_all_patterns_found.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
> >> CHECK_EXIT_CODE=$?
> >> 
> >> print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
> >> -- 
> >> 2.43.5
> 
> 
> 
---1463776256-1326094925-1731578743=:9263--

