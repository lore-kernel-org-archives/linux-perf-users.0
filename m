Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33992628C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827541; cv=none; b=Hk0lEf1GRUSIU82KzZ1HOSDdQol5eruTJSh7OLhq1cf4D81lx4/ihg2tIMa3c17oCf4GTb4L1j1JdFpHTq8t1v8Pr69Q6gROcIvHYfR8j0880RD1WNWDh6cUvwo/xGUdzkl2e0fwFoHJuDvdln6y4OFSI46ct+F0416nz6L43Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827541; c=relaxed/simple;
	bh=M1hWD/oSou+r5X9ScN+rHnKhewbykMu1plQom+IBOPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKyq5osu67faVfnk07f83WniCf8t8mepA9JxLuHHpHQB70B8M21KdoIVT3pgi4ZbeKDz3qnrEfC45QPaYl2UfHGt37b5XzzARJxQzHrAAqZ/A4/OUBe0lrsTVEvwx+Q28X8QMjAHK/PjYLImy2IM6PkgofDeg7l2oJGYp/T7X9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQ5YVIIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ5YVIIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ECA6zhUqnyZiEyBYCMUo+zUIFQyB0/m7K5nNM3gOBd8=;
	b=PQ5YVIISV7GTa8IHJlvbbds7oCD5btkyP+6ALsH78mbSxdA0ww2OPtVLQIJHwgdxhHd25/
	lKg76ew9ppRZxqDKayfd3n2FnvUOgLJBsr/xh7nVpqw25gy22xh6EkCbcfVnjIQN/AuLkT
	kDvqpcWeaoMnFE5kuZT8WwbEAXRoMtc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-BAnIxituMdOFwTuiTKpHiA-1; Mon,
 24 Mar 2025 10:45:33 -0400
X-MC-Unique: BAnIxituMdOFwTuiTKpHiA-1
X-Mimecast-MFC-AGG-ID: BAnIxituMdOFwTuiTKpHiA_1742827531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BF5618001FC;
	Mon, 24 Mar 2025 14:45:31 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35794180A802;
	Mon, 24 Mar 2025 14:45:25 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	mpetlan@redhat.com,
	tglozar@redhat.com,
	jbrnak@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3] perf test probe_vfs_getname: Skip if no suitable line detected
Date: Mon, 24 Mar 2025 15:45:23 +0100
Message-ID: <20250324144523.597557-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In some cases when calling function add_probe_vfs_getname, line number
can't be detected by perf probe -L getname_flags:

  78         atomic_set(&result->refcnt, 1);

	     // one of the following lines should have line number
	     // but sometimes it does not because of optimization
	     result->uptr = filename;
             result->aname = NULL;

  81         audit_getname(result);

To prevent false failures, skip the affected tests
if no suitable line numbers can be detected.

Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
v3:
- ensure POSIX compliance

v2: 
https://lore.kernel.org/linux-perf-users/Z9tKat6vvC1XUj0U@google.com/
- check if return from add_vfs_getname equals to 1
sice it is only option in case of fail 

v1:
 https://lore.kernel.org/linux-perf-users/Z8pAep0GJsMFTyEi@google.com/T/#t
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh          | 8 +++++++-
 tools/perf/tests/shell/probe_vfs_getname.sh              | 8 +++++++-
 .../perf/tests/shell/record+script_probe_vfs_getname.sh  | 8 +++++++-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh        | 9 +++++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 5c33ec7a5a63..89f72a4c818c 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -19,8 +19,14 @@ add_probe_vfs_getname() {
 			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
 			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
 		fi
+
+		if [ -z "$line" ] ; then
+			echo "Could not find probeable line"
+			return 2
+		fi
+
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
+		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
 	fi
 }
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index c51a32931af6..0f52654c914a 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -13,7 +13,13 @@ skip_if_no_perf_probe || exit 2
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [ $err -eq 1 ] ; then
+	skip_if_no_debuginfo
+	err=$?
+fi
+
 cleanup_probe_vfs_getname
 exit $err
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index fd5b10d46915..1ad252f0d36e 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -35,8 +35,14 @@ perf_script_filenames() {
 	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
 }
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [ $err -eq 1 ] ; then
+        skip_if_no_debuginfo
+        err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 60fccb62c540..5d5019988d61 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -25,9 +25,14 @@ trace_open_vfs_getname() {
 	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
-
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [ $err -eq 1 ] ; then
+        skip_if_no_debuginfo
+        err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
-- 
2.48.1

