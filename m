Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CD12CDB1
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994965; cv=none; b=fF3IcRyinJhoTuh+EJlck8tE9oCTaFtqFcnZzxmOkLNbX2zljJ/NWGRLTsq6j/ImeZ9+9GfoGFKrhRUb2a+r4/hBeI7WxxZRZgr0SRCCpJQeMzXztNiuYnZ4MahXEaukHbgHPJ5zRBv4ghAIO98rmB2uCTaMU9TWCunwIqOxXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994965; c=relaxed/simple;
	bh=DXyYqiqnmuBrwEqeDmGduu393lhmBVaDfD/iH9o+fVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ouNrqCIxiXV5fRDUWHUo62jFXf6mJLhDAyF8L21hBiXl3r1cuVJNKamKmD2J2CWypndW/zM4cSVj2wywUipGDmmvhYYZioK2BXzDJ/at/Qk0Yqcv3WSjbddU9d8Egcn5Mm4PuPWxy5M3do7xU9LvmJWOY9l2fdGLArR45gKdLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzP7BLQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzP7BLQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=zxc6bBwvuPPudVHLVuOYWWykw1koIdKehM/OxErRjMA=;
	b=CzP7BLQdQdOpwCj3agqEt7CW6+DGiUnHCA/yhqu5epJoauSvLjqmpbhEAeJ2gCY0r9TLMh
	PWw6xDXQjLmHBxugjHutPlx3pFOrRrRXxCC8vL+5vjYaWkxbrhwFk5bEkdHZZzTKL9zDbj
	N47qdMkKfvmkXJzV9JdBiajlEMcYifU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-LxOk7s_JP96eGYiL6dcASw-1; Thu,
 15 Feb 2024 06:02:37 -0500
X-MC-Unique: LxOk7s_JP96eGYiL6dcASw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 971522812FE8;
	Thu, 15 Feb 2024 11:02:36 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A8822166B32;
	Thu, 15 Feb 2024 11:02:33 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com
Subject: [PATCH v2 0/7] Add perf testsuite into perf-test
Date: Thu, 15 Feb 2024 12:02:24 +0100
Message-Id: <20240215110231.15385-1-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Hello all,

as Arnaldo said, this is a first patchset of an effort to upstream
the external perftool-testsuite [1] and merge it into perf-test.

The perftool-testsuite originates back to 2015, when there were no
shell-based testcases for perf. At that point, perf-test contained
rather "unit-tests" and there was a need to test perf as a tool too.

Nowadays, as perf-test contains shell tests too, it might make sense
to merge it in...

Apart from ~ 70 test scripts covering quite a lot of perf functionality,
it also brings design patterns that I consider advanced and useful:

  1) A possibility to keep logs and temp files for later fail
     investigation. This is necessary when the tests are running
     on machines that are immediately reinstalled and reused after
     the testrun. With the logs, many fails are easily narrowed
     down even when not having the machine online. Having variable
     PERFTEST_KEEP_LOGS=y keeps the logs in /tmp/.

  2) High level of configurability allows it to be run in deeper,
     thorough mode, as well as an "smoke testing" CI mode. Also,
     switching to different loads measured by perf is easy, just
     by setting CMD_SIMPLE (defaults to command `true`) to a
     user-defined application.

  3) Multi-level structure of the tests and subtests -- the tests
     are organized by perf-subcommands, test scripts and subtests
     within the scripts. Everything is reported in the results,
     when verbose output is enabled, so it is clear that e.g.
     perf-report failed due to preceding perf-record hadn't get
     samples, etc...
 
  4) Shared/unified result checking helpers and regular expressions

The perftool-testsuite is widely used at Red Hat for testing perf,
as far as I know, there are some users also outside of Red Hat,
but merging it into perf-test will help it spread and increase
the test coverage where it's still not known.

My plan is to move the whole testsuite under perf-test, respecting
both structures, as one perf-test "entry" per the perftool-testsuite's
"base_*" directory. Later possibly to align other shell tests with
it. 

[1] https://github.com/rfmvh/perftool-testsuite

========================

This is a v2 of the patchset, addressing the following issues:
  - shellcheck warnings
  - fixed regular expressions RE_LINE_TRACE_*, although they
    are not used yet
  - missing cover-letter
  
========================

Michael Petlan (1):
  perf testsuite: Install kprobe tests and common files

Veronika Molnarova (6):
  perf testsuite: Add common regex patters
  perf testsuite: Add common setting for shell tests
  perf testsuite: Add initialization script for shell tests
  perf testsuite: Add test case for perf probe
  perf testsuite: Add common output checking helpers
  perf testsuite: Add test for kprobe handling

 tools/perf/Makefile.perf                      |   5 +
 tools/perf/tests/shell/base_probe/settings.sh |  48 +++
 .../shell/base_probe/test_adding_kernel.sh    | 278 ++++++++++++++++++
 .../shell/common/check_all_lines_matched.pl   |  39 +++
 .../shell/common/check_all_patterns_found.pl  |  34 +++
 .../shell/common/check_no_patterns_found.pl   |  34 +++
 tools/perf/tests/shell/common/init.sh         | 117 ++++++++
 tools/perf/tests/shell/common/patterns.sh     | 268 +++++++++++++++++
 tools/perf/tests/shell/common/settings.sh     |  79 +++++
 .../tests/shell/perftool-testsuite_probe.sh   |  23 ++
 10 files changed, 925 insertions(+)
 create mode 100644 tools/perf/tests/shell/base_probe/settings.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_kernel.sh
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.pl
 create mode 100644 tools/perf/tests/shell/common/init.sh
 create mode 100644 tools/perf/tests/shell/common/patterns.sh
 create mode 100644 tools/perf/tests/shell/common/settings.sh
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh

-- 
2.43.0

