Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ABC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 02:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9660F45
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 02:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJKC3K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 10 Oct 2021 22:29:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19240 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232813AbhJKC3K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 10 Oct 2021 22:29:10 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19A7Pv14018183
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Oct 2021 19:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=R+8yjzS/cHngTmJx9VVXcB+dEeKhMINGWb7US1nn4Sg=;
 b=ate/DN1Zrecry+SjBSVU3BrNsvpsWy4YX4dueCv29kIOASyZN9iCRCwV4YbZlbZH1+mJ
 HKcWwhBrGX+uTVc5jVhtsHA2EkAzmkCNQCScrMFZ85Kj06/BVq4Nt8U3riztapZ8SpZe
 pB0Ha3njYQOpr9Qp1q3GJE5bFPbwlciPnNs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bkus44522-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Oct 2021 19:27:10 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 10 Oct 2021 19:27:08 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id B7DB17D98F30; Sun, 10 Oct 2021 19:27:05 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Sun, 10 Oct 2021 19:27:00 -0700
Message-ID: <20211011022704.2143205-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: WUdBi2Uoxz7ABb0JixyopNGWNeHDCFfN
X-Proofpoint-ORIG-GUID: WUdBi2Uoxz7ABb0JixyopNGWNeHDCFfN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-10_07,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

bpf_program__get_prog_info_linear is a helper which wraps the
bpf_obj_get_info_by_fd BPF syscall with some niceties that put
all dynamic-length bpf_prog_info in one buffer contiguous with struct
bpf_prog_info, and simplify the selection of which dynamic data to grab.

The resultant combined struct, bpf_prog_info_linear, is persisted to
file by 'perf' to enable later annotation of BPF prog data. libbpf
includes some vaddr <-> offset conversion helpers for
struct bpf_prog_info_linear to simplify this.

This functionality is heavily tailored to perf's usecase, so its use as
a general prog info API should be deemphasized in favor of just calling
bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
examples from caller migrations in this series:

  * Some callers weren't requesting or using dynamic-sized prog info and
    are well served by a simple get_info_by_fd call (e.g.
    dump_prog_id_as_func_ptr in bpftool)
  * Some callers were requesting all of a specific dynamic info type but
    only using the first record, so can avoid unnecessary malloc by
    only requesting 1 (e.g. profile_target_name in bpftool)
  * bpftool's do_dump saves some malloc/free by growing and reusing its
    dynamic prog_info buf as it loops over progs to grab info and dump.

Perf does need the full functionality of
bpf_program__get_prog_info_linear and its accompanying structs +
helpers, so copy the code to its codebase, migrate all other uses in the
tree, and deprecate the helper in libbpf.

Since the deprecated symbols continue to be included in perf some
renaming was necessary in perf's copy, otherwise functionality is
unchanged.

This work was previously discussed in libbpf's issue tracker [0].

[0]: https://github.com/libbpf/libbpf/issues/313

Dave Marchevsky (4):
  libbpf: migrate internal use of bpf_program__get_prog_info_linear
  bpftool: use bpf_obj_get_info_by_fd directly
  perf: pull in bpf_program__get_prog_info_linear
  libbpf: deprecate bpf_program__get_prog_info_linear

 tools/bpf/bpftool/btf_dumper.c                |  40 +--
 tools/bpf/bpftool/prog.c                      | 153 +++++++---
 tools/lib/bpf/libbpf.c                        |  15 +-
 tools/lib/bpf/libbpf.h                        |   3 +
 .../Documentation/perf.data-file-format.txt   |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |   3 +-
 tools/perf/util/bpf-event.c                   |  41 ++-
 tools/perf/util/bpf-event.h                   |   2 +-
 tools/perf/util/bpf-utils.c                   | 261 ++++++++++++++++++
 tools/perf/util/bpf-utils.h                   |  76 +++++
 tools/perf/util/bpf_counter.c                 |   6 +-
 tools/perf/util/dso.c                         |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/header.c                      |  13 +-
 15 files changed, 526 insertions(+), 92 deletions(-)
 create mode 100644 tools/perf/util/bpf-utils.c
 create mode 100644 tools/perf/util/bpf-utils.h

--=20
2.30.2

