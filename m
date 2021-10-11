Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24CC43217
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAE160EB1
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhJKIWq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:22:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18640 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235020AbhJKIWp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 04:22:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B72kmA000821
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 01:20:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ULXzGe5b9hnLPGhtsBXPm+42/+jnSuGrS2IH7zVxYkg=;
 b=QZb1Y3EKtm6E9nl8lJ/XWN8CtqNXKO5SlKZRSi18a+Me923srC4a21+QVi7G4GgJEDLI
 9bvCOzEYXP4HKXvVD/OLpuGJEGEUaW3Lv34Evp+21rd9VPnrlEktTEnfWbkQe2Ba1NOp
 uvDU6aKV5muv50tzpCcVROP8vgB79isjuxI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bmghfrfek-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 01:20:45 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 01:20:43 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id BF2EB7DCA10B; Mon, 11 Oct 2021 01:20:32 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] libbpf: migrate internal use of bpf_program__get_prog_info_linear
Date:   Mon, 11 Oct 2021 01:20:28 -0700
Message-ID: <20211011082031.4148337-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011082031.4148337-1-davemarchevsky@fb.com>
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bE5IliZUd_-Kgifm6KlnUCcwAsnAnbXN
X-Proofpoint-ORIG-GUID: bE5IliZUd_-Kgifm6KlnUCcwAsnAnbXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=905 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110048
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

