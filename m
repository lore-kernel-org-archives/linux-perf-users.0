Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8873290B1
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518762; cv=none; b=bqpDbfZrm4qEFY8HsiLFHb0kNd1wliC8NnlAGy5zi1UBag3L+TL8Gw1e+RLc6mzXI/Ux8Jxh9BqLIP3MdUXwXoLv7/tXAfTXkhGk3qqJvBB+e2OiEchOGQdh/XgdlB2Tp0jK7bVe5HbRnIxj95v0Kg/Lr8Pts2A2CnywO3UuLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518762; c=relaxed/simple;
	bh=WYFI/yXArUZr1Bf5IOK7mBBFES9i/VWIMEpbANuxMi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fot/lHI2clH9aoimeVxYoQvwsYxp/DAjgVYLv+dc/WAzTUjoGvjJHiocqnQ0DWOTw7metoudiP4zlPOvFfam0cEysNltwXba9CTBQffEILMFnbQB5KFVlCQ7lRMclP/iiKpsb73A2YlqXOSroIlCWRyo5O2p4JOMmCdvWUWif+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2ngl/oH; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2ngl/oH"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so199713a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786518760; x=1787123560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tyBO8NC8dL/S3ecgA93K7mZkSYmsUhdwIIKYrIDqlDU=;
        b=D2ngl/oHD02ZVKkGodrBPMFDVJA7LursCCaeddHC/C7bBXGAYBuZomTAHN5RuW6+/i
         0uiXuVZuh4kQmMPJ5xHDUKBpge3Z9di4ujPS8274cAlXrRDaaApfT5xuZ7KAOkk2Cp/j
         ynYXmscmF7bdBAy4igotptV9Pbmxu/TQR78cCk8BABEZtWo2SHOgukUps/t05AShVYms
         3E7PTl8t/Uq5HL6QQyVW/opYJ8Vq2c31ilU/2tVC0/z8cL5bUNQtEbBBjpD/7KjUlR+I
         4VqsyNrTfz3J0DZjyq7t6W5wMOHmJ7dZZhuwborVwC2zs7UFeN1rzXDLrO12WHknd6F/
         xW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518760; x=1787123560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tyBO8NC8dL/S3ecgA93K7mZkSYmsUhdwIIKYrIDqlDU=;
        b=baAK0fdT4ARPbUh2NLLmzQHGCiHejls4xsAI/KCkt/Eckz7SqlZ0mYNlRmFeNJJrpM
         Kz0UmI1ZTgH6sXoLer/00cmxFpX4uQvnCmlZxhlcV46n9gyJY12yr+LuhdsFOFKsEkCp
         2EN/+5B1tgZExH1vaKMTF9E5gVncnnChvWrEnxgIhJzrpsdapC0gVvg4NYPcPtHcWTnX
         wCRfSAsjdd/uEJBduQ0YdiOMKnrPqlANbsAC3MoRj9VoacRBfre1T1tczDpJEXyDM64/
         cNsFs2QVH5Emd8l0BNp+of3QcOzM2mm8NC4yx3oczYZZbmzhov4EAEpXB6YI94qSi0ZX
         VuVA==
X-Forwarded-Encrypted: i=1; AHgh+Rrcf8D0kySdlua/I1P0DRTgd44Esj0wjf7ensYgssm9T4fWsghexzPhNVuhX+r7On5k1MNQq6K1vxR6k7WKE1rY@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvhjNUokVfxJilq6W0nzRKS5aja0/1EkfMCGG7i9CRS8eYOmO
	9D1Quq4ckAS5BHxa6jBTrQJ0Q8Q1vOGC3jgf3HQaVxCLp9x+RFa66xNm
X-Gm-Gg: AR+sD10A5FPN9fv3XYo+kOzpkd52fs1KErwhErCPilLrqtvwbi1guoLEtpkG3GI/eEu
	AcTD573m7IZXYADfGHJYu9ll5ck9/I+tKOLaPv5zR71ZWdqbXqUQr/lDPVcbJye2iAxYfJAaSwe
	jG8drTXULPwpVGv2VvKplth95fxzAXzmWaKb9sKNDJKvkFMmazxSHv7ZWChtDHKVADMHIgB4ZLA
	dJ7sJBRvKz23Ki9SWShmXyA9dSS8JsdkqidoUjTfXck7ltyjuEwm6MIYBoCv0r24txj6CTW8qmh
	dL5SzjB2jsMq2FLNRUq7s8LeIApSy2VHnd9ox62mpKLYL3P1seTH32puCX5ZS45TR6Hx0YKKPXX
	jkAFztGcg+imNpgMRhB+KdLMtKLKDUcVKdjL0ySeVtklpsG/+5GWpxIw14ZPOO8orTZA49fjUq0
	T377xTitCUD9Nef6TfvW9baIcPeO9SXXjF6H3Oa7og1ab/wnmH74PZNcVGDMWRwKYhb50MhKCSA
	2r0w1XEkSelHK1nZVT9knjvN5v65Oo=
X-Received: by 2002:a05:6a00:14cd:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84fb55b1778mr3104529b3a.38.1786518760560;
        Wed, 12 Aug 2026 00:12:40 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d16673sm258313a12.16.2026.08.12.00.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:12:39 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
Date: Wed, 12 Aug 2026 15:12:31 +0800
Message-Id: <20260812071231.201931-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fe324606174e1f9e@google.com>
References: <000000000000fe324606174e1f9e@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..ee3d8ed11699 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -84,6 +84,7 @@ static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
 
 u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+u64 bpf_get_stack_sleepable(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 				  u64 flags, const struct btf **btf,
@@ -1705,6 +1706,32 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_get_stack_sleepable_raw_tp, struct bpf_raw_tracepoint_args *, args,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	perf_fetch_caller_regs(regs);
+	ret = bpf_get_stack_sleepable((unsigned long) regs, (unsigned long) buf,
+				     (unsigned long) size, flags, 0);
+	put_bpf_raw_tp_regs();
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_get_stack_sleepable_proto_raw_tp = {
+	.func		= bpf_get_stack_sleepable_raw_tp,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1714,7 +1741,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_raw_tp;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto_raw_tp;
+		return prog->sleepable ? &bpf_get_stack_sleepable_proto_raw_tp
+				       : &bpf_get_stack_proto_raw_tp;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_tracing;
 	default:

