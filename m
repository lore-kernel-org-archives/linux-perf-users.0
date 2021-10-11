Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F9C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 02:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355A060F45
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 02:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJKC3M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 10 Oct 2021 22:29:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhJKC3L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 10 Oct 2021 22:29:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19A7Pv16018183
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Oct 2021 19:27:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ULXzGe5b9hnLPGhtsBXPm+42/+jnSuGrS2IH7zVxYkg=;
 b=VYrvg1katQFF6dNBmiuKBVl7Q1PzxwS1L2lZitgTdVM8Azhg3jh1atuVoK0Z+EYyM5NU
 Fbsi+zMgU64HOzBIG9fGyV8eLx+/8TdkdXItJdxO1eh13RSE+ArJ+jkFMGwDPgtB4MSA
 9qv7a3IxlRvX9NeycM61KM4zJZi2huKWonU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bkus44522-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Oct 2021 19:27:11 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 10 Oct 2021 19:27:08 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 18C377D98F44; Sun, 10 Oct 2021 19:27:07 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/4] libbpf: migrate internal use of bpf_program__get_prog_info_linear
Date:   Sun, 10 Oct 2021 19:27:01 -0700
Message-ID: <20211011022704.2143205-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011022704.2143205-1-davemarchevsky@fb.com>
References: <20211011022704.2143205-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: LFMigxhSJlgCgmP3RP4XonhybZ4janes
X-Proofpoint-ORIG-GUID: LFMigxhSJlgCgmP3RP4XonhybZ4janes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-10_07,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=905
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In preparation for bpf_program__get_prog_info_linear, move the single
use in libbpf to call bpf_obj_get_info_by_fd directly.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ed313fd491bd..8b86c4831aa8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8459,26 +8459,24 @@ int libbpf_find_vmlinux_btf_id(const char *name,
=20
 static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_f=
d)
 {
-	struct bpf_prog_info_linear *info_linear;
-	struct bpf_prog_info *info;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
 	struct btf *btf;
 	int err;
=20
-	info_linear =3D bpf_program__get_prog_info_linear(attach_prog_fd, 0);
-	err =3D libbpf_get_error(info_linear);
+	err =3D bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
 	if (err) {
-		pr_warn("failed get_prog_info_linear for FD %d\n",
+		pr_warn("failed bpf_obj_get_info_by_fd for FD %d\n",
 			attach_prog_fd);
 		return err;
 	}
=20
 	err =3D -EINVAL;
-	info =3D &info_linear->info;
-	if (!info->btf_id) {
+	if (!info.btf_id) {
 		pr_warn("The target program doesn't have BTF\n");
 		goto out;
 	}
-	btf =3D btf__load_from_kernel_by_id(info->btf_id);
+	btf =3D btf__load_from_kernel_by_id(info.btf_id);
 	if (libbpf_get_error(btf)) {
 		pr_warn("Failed to get BTF of the program\n");
 		goto out;
@@ -8490,7 +8488,6 @@ static int libbpf_find_prog_btf_id(const char *name=
, __u32 attach_prog_fd)
 		goto out;
 	}
 out:
-	free(info_linear);
 	return err;
 }
=20
--=20
2.30.2

