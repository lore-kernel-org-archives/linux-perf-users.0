Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F6C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D23860F0F
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhJKIWk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:22:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50090 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbhJKIWk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 04:22:40 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19AHiLTg030733
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 01:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=b7pkDAxUwFHuY98PeB5JKim6bI7wBJulvVioRqy28Nw=;
 b=jrpdZrFXkbZsSFtFjnm0WQ3iM0yVXGrbWcEK2UUycKnqOVPMXxSTI5fjxl27wSsWtuBC
 d03yrBoJ1C8ZT4z3UhCIR/Y5grV6J0nBo1oFQhCYENTP5vgf+iXBqNSxJ5ZtAzmLLZff
 6M18hRdoZkHOtFvep0fUZvvQggAl195UKYQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bm4u73dux-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 01:20:40 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 01:20:37 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 040C27DCA0FC; Mon, 11 Oct 2021 01:20:31 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 0/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Mon, 11 Oct 2021 01:20:27 -0700
Message-ID: <20211011082031.4148337-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: xPsjzNPu-ZxU6XyMUe5Mdse3-ButuOWG
X-Proofpoint-GUID: xPsjzNPu-ZxU6XyMUe5Mdse3-ButuOWG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110048
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

v1->v2: fix bpftool do_dump changes to clear bpf_prog_info after use and
correctly pass realloc'd ptr back (patch 2)

Dave Marchevsky (4):
  libbpf: migrate internal use of bpf_program__get_prog_info_linear
  bpftool: use bpf_obj_get_info_by_fd directly
  perf: pull in bpf_program__get_prog_info_linear
  libbpf: deprecate bpf_program__get_prog_info_linear

 tools/bpf/bpftool/btf_dumper.c                |  40 +--
 tools/bpf/bpftool/prog.c                      | 154 ++++++++---
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
 15 files changed, 527 insertions(+), 92 deletions(-)
 create mode 100644 tools/perf/util/bpf-utils.c
 create mode 100644 tools/perf/util/bpf-utils.h

--=20
2.30.2

