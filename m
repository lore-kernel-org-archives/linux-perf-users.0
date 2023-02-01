Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492EDC05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjBASFM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjBASFJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 13:05:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD737E6F9
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 10:04:57 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311HfmTm022053;
        Wed, 1 Feb 2023 18:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=493bH3d2Qv0pxlRnBsi97QAxpjRypzLVY2rTEnU9IJs=;
 b=Zfx3J1Y0/0zqoH9IJths/eFL1ENRagojpdpOqYh8eOPvMgdcRP8kKtlh80uaoYFof9HA
 9cVRTUjBpUttDjToLncEe5JWC0i5O/6OGTuVATOwwOQqmi3X3hZy0OSFp4vBaWPf29Ur
 kWQ1Uli9Ddyfgfj8EznVXuHJ6EdOE+xySzBQp5feA2t0o0QSvwdEAnESj+xkzpLLq/zQ
 9dA9I1yxL9skTr1l0HQOaquHI2u1kisjZ7mh5Bll6TPAFdQOyM7lfqVQDAMVqBg7eEE+
 T+zKtMuLEMj0KkYkvUYAIrkK6EGp0zY1HDDjTf/VQz68QrP7pLQLAGA4v07KGG94aB8R Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfv9n143r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 18:04:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 311HpOE0030188;
        Wed, 1 Feb 2023 18:04:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfv9n142u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 18:04:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3117RZIm013277;
        Wed, 1 Feb 2023 18:04:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtyd73k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 18:04:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311I4TRv43778530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 18:04:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689B72004B;
        Wed,  1 Feb 2023 18:04:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F52C20040;
        Wed,  1 Feb 2023 18:04:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.62.134])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 18:04:26 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH 2/2] tests/shell: Fix perf test shell to check for libtracevent support
Date:   Wed,  1 Feb 2023 23:34:21 +0530
Message-Id: <20230201180421.59640-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230201180421.59640-1-atrajeev@linux.vnet.ibm.com>
References: <20230201180421.59640-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vf2YRv_6dFQTxJW8zGXd7GRz2dv2pibK
X-Proofpoint-ORIG-GUID: nnXNflErMAEC10MFw0OqEQ05xdxn6Nm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010155
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Test “Use vfs_getname probe to get syscall args filenames”
fails in environment with missing libtraceevent
support as below:

 82: Use vfs_getname probe to get syscall args filenames             :
--- start ---
test child forked, pid 304726
Recording open file:
event syntax error: 'probe:vfs_getname*'
                     \___ unsupported tracepoint

libtraceevent is necessary for tracepoint support
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events
test child finished with -1
---- end ----
Use vfs_getname probe to get syscall args filenames: FAILED!

The environment has debuginfo but is missing the libtraceevent
devel. Hence perf is compiled without libtraceevent support.
The test tries to add probe “probe:vfs_getname” and then
uses it with “perf record”.  This fails at function
“parse_events_add_tracepoint" due to missing libtraceevent.

Similarly "probe libc's inet_pton & backtrace it with ping" test
slso fails with same reason.

Add a function in 'perf test shell' library to check if perf
record with —dry-run reports any error on missing support
for libtraceevent. Update both the tests to use this new
function “skip_no_probe_record_support” before proceeding
With using probe point via perf builtin record.

With the change,

 82: Use vfs_getname probe to get syscall args filenames             :
--- start ---
test child forked, pid 305014
Recording open file:
libtraceevent is necessary for tracepoint support
test child finished with -2
---- end ----
Use vfs_getname probe to get syscall args filenames: Skip

 81: probe libc's inet_pton & backtrace it with ping                 :
--- start ---
test child forked, pid 305036
libtraceevent is necessary for tracepoint support
test child finished with -2
---- end ----
probe libc's inet_pton & backtrace it with ping: Skip

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 8 ++++++++
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 6 ++++++
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index ed0a3972c4c8..60c5e34f90c4 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -22,3 +22,11 @@ skip_if_no_debuginfo() {
 	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
 	return 1
 }
+
+# check if perf is compiled with libtraceevent support
+skip_no_probe_record_support() {
+	if [ $had_vfs_getname -eq 1 ] ; then
+		perf record --dry-run -e $1 2>&1 | grep "libtraceevent is necessary for tracepoint support" && return 2
+		return 1
+	fi
+}
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 08cdd902d0cf..b4149b2db4c6 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -11,6 +11,7 @@
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
+. $(dirname $0)/lib/probe_vfs_getname.sh
 
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
@@ -57,6 +58,11 @@ trace_libc_inet_pton_backtrace() {
 
 	perf_data=`mktemp -u /tmp/perf.data.XXX`
 	perf_script=`mktemp -u /tmp/perf.script.XXX`
+
+	# Check presence of libtraceevent support to run perf record
+	skip_no_probe_record_support "$event_name/$eventattr/"
+	[ $? -eq 2 ] && return 2
+
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
 	if [ ! -e $perf_data ]; then
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 7f83b2715b9a..1341437e1bd9 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -17,6 +17,9 @@ skip_if_no_perf_probe || exit 2
 
 record_open_file() {
 	echo "Recording open file:"
+	# Check presence of libtraceevent support to run perf record
+	skip_no_probe_record_support "probe:vfs_getname*"
+	[ $? -eq 2 ] && return 2
 	perf record -o ${perfdata} -e probe:vfs_getname\* touch $file
 }
 
-- 
2.39.0

