Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA711BFE0D;
	Tue, 10 Dec 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848327; cv=fail; b=O6juwoRYnS8smVxtcBCPj3tLF45oEGeCe27WUqV/ZQ6R6vwvVTXC4eIqTWZQdEQeUCDXxwdi7J5nT1BxA2nuaQplP+H7coksRNnmL35RCdMRWb49Tpel45rVIB6To25T2qgJbE9ceto0RiUdMvRXH+RcRju39n9p3Knpb0TyOwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848327; c=relaxed/simple;
	bh=mnS3RW7Wy9fSp/rTuKvj+JZOAUZER1vaPk66xqmgCpk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NAz+sHdAluDnVCHHzoHyejSGW/Vg+6DBFKORKw9WrkNUfA0fHcSRxWkkvb4T276BiiOt5VsQizDHg+Jq4AsC2+aMtClt8ye28J791a0Y4DATp1CwMPyTmqgpAGbX9sqHvPWUWbYBGeyDCgP6foyi2yYJmQIEbhtnNHPfYoPgpUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XFvVw340; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NG35JVcA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFvVw340";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NG35JVcA"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGR562029925;
	Tue, 10 Dec 2024 16:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=T+ql8G+kOGYFzJuE
	UkV8hlZWF0u/gd9NDIN4cCMrwUA=; b=XFvVw340PHTGiWumiFSarH7sxfQroVPo
	zayxe76vJErPms+RshA4DGP8Z1UbiZLrC2QknPMoe1OP2PcZtRMoetqsh8QKO/Iv
	i5GL2q4Nc5vVKhssvtPCmoakEMm6QaJ78RleZJQtVzFacaxQsO0HdcnotROi1Iug
	chvQ583aBWsbOjPqXzcCCa5X35LgRpkLYZRFBClHFkRQbEbnLB5ATCzCGQWu/oop
	ziCEcQRbWhBMCRl3BbZLUYOJEth4w+ozGSPrJICgd+qRXjBHf9X/w1mgxMUaldp2
	VYciqSPo3vgPsTQEJSPy3rsqGcPqn8s2xVqa9jPLt5jnDoAim9h/GA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89643x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAFl6ct034912;
	Tue, 10 Dec 2024 16:31:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctg1d8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO91dW+7+I1fU/N+Zzl7Z6XDwOD5cyyyvudZPglC6wuc54QxYf7QIQxID3f60c4ZNO+p/4SEWdBzGRPTf9k4Y55R/RcEmb0v0sOm+fJn/WVn/5sIsqE6yl4Lxfrc4EgwELoWWYl/6fFsahYBZ9sR2lAcSM8N1/iPKUgXIW6tL4l/HfAjh3uffAUdnFwZnYtFAZBOkmq4MVOEVJZSIWjn998EHWiVgbq2gNwevi1CnPELFnr4NwhSYCNoYOW3yeNGYAxf7MmbeLPjy5bXH3FKyEH+cERco7Cu7GKWMwr4WtO3AuzCMvdo4NafBM8bu3RP1UWhJiycHyCBQuIzlzsUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+ql8G+kOGYFzJuEUkV8hlZWF0u/gd9NDIN4cCMrwUA=;
 b=MKjX4XwlkUb2IIYl3uL0NsrmqX+wtilr/dfUZLgqBBoBI+achFYuUN/onXUkBBXkmBvDzKqtMldYtwe0SJruBiFm5CzBO1zy78AVygYqhUQnpC64DOgEvwfcJtCmWaxiz7GQm60Zg1cloGYNE4UMSvoUM25unG69SJbS6cxRVvl5dduYkRkfVdgfvBYuaAlHLhEUFKTD6TS4IjyWII+0rDoJozNGc9Kefp/mm/rUBS4Hf0Mylx5iIjLdmyEgDFgPkm6nPEM752YXnTCxRRqMlrfC7+VtgnzNL8UQkjVIvNxdfg200bxmA64SmYwTNh4+K4VKRfWfuKdcgGEOdersXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+ql8G+kOGYFzJuEUkV8hlZWF0u/gd9NDIN4cCMrwUA=;
 b=NG35JVcA/+FvrVmHt+F0GLeFWNgJ6io1DffzPFspM3uiCLV7VDa6Pi09oxbRRBFujJiUQ4Le2wRqUa9ZTvem64x/JN4F/VKJciaEdqarEmW14xW2UkZtbTv9HfixW7PWzR72AxsP6W5E2f9t9xkasNAkvZ6yg3cmefUv6Ovr67c=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7405.namprd10.prod.outlook.com (2603:10b6:8:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 16:31:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 16:31:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Date: Tue, 10 Dec 2024 16:31:04 +0000
Message-ID: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e846243-e236-49b0-df18-08dd193813c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x97JMeLRE8vPF92wUIR8bqLIx8xRIJo9mMWbOfmeG7zfZ7nvfJy4Q/IjQgZU?=
 =?us-ascii?Q?IW6O05L3O5kg45JSHciizShWT+hGQ21OtRUrC8TvroJRUUJlKxW5ZWF3C8uo?=
 =?us-ascii?Q?WYZSQ1IhRKZbWzANxdtYIxUxW2x+gJ1+TLWS0v0dREeZz+fKomSrOB/pPL+I?=
 =?us-ascii?Q?E+IKQOP/eA9bP94/i0oITtwoWQe2+DDmbQSMADkF+NHpwvNimXyqTZf7KTED?=
 =?us-ascii?Q?qfqpC5856bM5bV3XH8+HTW91ghoYkmdPZI17CHdDZs97sbBTPbNKyILWC1TP?=
 =?us-ascii?Q?4+cSLVjiSQZMQLf7/B/YOm8xjPqOGhzE3v8MRD1V9Ytx+13yKOMT9LRLBr3J?=
 =?us-ascii?Q?WUZ/6meVDgHcmOTNTVzZDDkCP5ETG4pD++NgXAbJDImyx/9BgXC6qtgBBGFE?=
 =?us-ascii?Q?ykCsJErVqt3fyjjgTfa9/O1uckLIsQZ2wKxzco1NZ2zhALb8xIJpYmDePuTE?=
 =?us-ascii?Q?9soaPwkBsEiZ2VKChVzofazsrujXje/J9YbKdPcip8Aa4Y/nQjjZb2oBY6ch?=
 =?us-ascii?Q?spxr9vMlCWSpJqxOz8Q+CsFXo0QYxG5owlBIlar28bOpvZ7uqWuSg/IGw2Bd?=
 =?us-ascii?Q?lbyYZH3m3QMKLGTGgJ/DN4weSg3hpImvZpTwErWjFqnZTlfqs4e/ExtkuOH+?=
 =?us-ascii?Q?g9EfE3lK5NRgoSrZ+yXoIzKWjZTkh/xZE+SVoovTzcFx7PtyFYTun3mrzAS2?=
 =?us-ascii?Q?EzcycaesHZ9qqU5xHHhVc4IQfP2G6paz8m343TTtQUE8cUamOUAqEuMxe1lq?=
 =?us-ascii?Q?i0DtUjGCJ1ngUrWNL+ArgLNkEKNFz8oWiX5VtHlsOYNNwIVaiAfmfqFzkvmc?=
 =?us-ascii?Q?Py422WtsrRcGqp0UnBGWa7tzr8l7nFNFnItYClpSKeAyLiNJJuzhjd2eaatQ?=
 =?us-ascii?Q?ZoFZ1V1KwkRyQC9EkpMgGsKAYxzgVnAHTe/nxLaR0Fnx+QUrUes7s6nPd8kQ?=
 =?us-ascii?Q?QVG15sS4Va4laXjcmIx/O4JNVFp60WsMMZowG1uUkaFFokAH1AYSMQRbpog6?=
 =?us-ascii?Q?VKlXfYSkrTQT4b9DFHioYBt04BC2HmPiJsdgUxkAF5U/kSTiShrA9ZodCgOr?=
 =?us-ascii?Q?G6+L3CsJaMfT2cplbbolDqJai962Foa3BAvtbKW5ya9oSlsDwdevpau/qm5S?=
 =?us-ascii?Q?Lw21nbuuqGWdSEp8CFa8wIUFqEyDToQGV4FZRMivhQbKop4ANbsh9ZPsjuKb?=
 =?us-ascii?Q?Fs02eywGDFeALy/0rOvXrhBbXB3bThyGTejlMXRKUjubn1ALE983F5ZP+rrW?=
 =?us-ascii?Q?tXaEwy6tx5/AfJCPF9qgEbVUZ3khsRmSMz/BU/vq9RMlueJnKPAe3+nixMpf?=
 =?us-ascii?Q?bSRGopg8VCiV3ZKQluzJcxtNMpgBSp9du5DnTAo3+dzolGrUjenqBbCZJJGQ?=
 =?us-ascii?Q?+bcXWA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Cg6gI5b2jt0DVN/JJdGgMp7AJTPd0c10RTuNEestQpUEId8JPbMHvdeARwC?=
 =?us-ascii?Q?GciKZdef3gvxrapXOnlRfBBy+JjulDSiE9PxMybeEACf/Ly5VuiK+U6kWo7N?=
 =?us-ascii?Q?ims4xHqDdRcEeuNq1+Q6H+yxK8Z4lf9m6r3eZkS8uTPePhesbOv5y9Ayovxw?=
 =?us-ascii?Q?5x3LiCzhvvA9GE6VfUfT84rBSrMdtoT0XjQ807Atqh7oXY5QANwbFDS44FX0?=
 =?us-ascii?Q?Izm19650cOwgd1Qm3Qp2DSmQYqqNSoHagF9sOBIO2grBEwKxK5cHFQdgFhkW?=
 =?us-ascii?Q?n/SYcFxV05JtFCwfc0Vqu3UAPFx1FtlwaCZdyZ7mIer8+sH5x1PjZMtP3SWN?=
 =?us-ascii?Q?gKUihbtI0ZneCEDL82uQgc6jTQXVkpesUR35kKE16ItGmQDHMH+PPD/bv3/R?=
 =?us-ascii?Q?2/QIR5t82liD883XPRmyUMdRdZKVuPQ0sXGgt2XvqUZwrifO6yCX/8G4oLLR?=
 =?us-ascii?Q?Xe1AllHDwZgKjlNFaz7glRJYRqqG6ocGPl8wHXvIj30QfvF+GAmPFVX//QDr?=
 =?us-ascii?Q?xjQRrZKq3Q/kFhHp98g7OzahEbsHZUUwcxdUmBaxFuT0pZiTQSZeExUe6amj?=
 =?us-ascii?Q?s6uSLb6ra1QyU9rF4FmT5J4+yMMT/9d3/uGoytM3uQjG1IhfnMnYY/cyxeN4?=
 =?us-ascii?Q?Ow59mTDyaqO+XVJp6C32MJZYqXCrri5SOcUlFlmA1HKQCtL4t5x5CpwH6YP9?=
 =?us-ascii?Q?Lp1KbPocpu/0r/RSd4qTGq7pxojd7r02mZCCRk54JWhLiiHcRp6NCGGKy253?=
 =?us-ascii?Q?8Iy39cGaJ6aBlj7eH1nl6fSQNmwBKXY0w788dpUxL8m1yhIG9qFtMtKCBMDq?=
 =?us-ascii?Q?plLgrpXBraypX5ZdWEl+UcpjtsOmO0tUOOeEYQYO0dHA6K2r32uN+bMaUNmK?=
 =?us-ascii?Q?wRkhJFoz15cIvhyUeCJzVrcupcyU7AzClmsKRTGhoNeWO/NN5M3Jksv5L8pe?=
 =?us-ascii?Q?u6Yz3F5lnHzOJGle9NE8KD0/139otwTfSauJr4uSqL0CsEL3C20kRnS8TYhc?=
 =?us-ascii?Q?YlF1NhS0LPwwzg62soeXM0fYaBS4LzvTWMlQr9PioMylpUBmOdAJo4IQzIl5?=
 =?us-ascii?Q?P/n39IQH/rlXtrPgYOcoYY4GN9T8NerEkuZlPRYY2WOzy/VVsbDjA95flqwd?=
 =?us-ascii?Q?KZi9OV9pG5Gxrq7b3PQlcY4LH/8i7dLmb7IWRDAK9Lu/PdHj/TKAfZQET7pP?=
 =?us-ascii?Q?VZtBl6+XSaKSZY+lRPqfqLKac0htyYEfh/maffQaPXAihy08bEB9LEAuh39k?=
 =?us-ascii?Q?fRG5fHOCbQu/aMLI3Ma8DYpLu32q3saRXy8Ipb5/C8RDqQzpnb6ZlcgzzkCn?=
 =?us-ascii?Q?tVT65YsBkTbGAFjb6UzMgvKV5vvRroy2/12x5XSd7horEnoei26Tjh9TgU44?=
 =?us-ascii?Q?O5z6tpXGUzRH3XH8Q1L7ax1C3N4wKpKl2xCddIZLqyT41UcVB24OZ2I7wdY/?=
 =?us-ascii?Q?4uPYLgKlZh7eGDaLuRvw3FWD2iyq34EfW2SjCKMcQLxa3gPk4K/kHKNy1jAO?=
 =?us-ascii?Q?TDlloBfPMCD3P4Jvk3W3CwnQVC8xW8fMWQsoXqlsoi2XRCyKl1Np8Uc1ZNAr?=
 =?us-ascii?Q?/YgQbw3BDyWv6yXhk5WpLJz3Jzmhi/+k/Vubkh+emWN8S4j/61VfSfy/6idZ?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	irr5SkigilpeR0h9aZcVHieSkLDRb3VwvTC1PiIqm3EzSMwlDDVp/Crmf8xrrpvnC97Wb2lw4/JZoxr+Lj3yesMk1kyaaeEy0unltBvM2UteJkdOAMWCCQTVCJ97gDvhQuHybzOCQN5bmjLnZI3q4pbvMCwiBgy5ds+yEj/l2SPFFiQYDNcOvQxRVSvZ72PbN3lSEB4g7horp/oofbbSg2eWkarHg6f/GZV7Jf3HZtUHhcqF5Afdg/DtXC6jYzaZVIkoZML67Ge6E6kCCZqC1iDgn8D1Vv9LBWZVDEiMCzR1dIlnO6dkoAYqX0ZHIKuzwElJfLKYqflXBEb4RCZf/+4DsDzAVBRC1yJFIVvvHGQjayMYY3xZTj9AhVhqKuVrrSyuOWd0TMNWptSN2LI6QLs+LKmyhbQc7OchVyUHgQWAS7hUvCuwNcyALDvIvaS6IwuRWer7+sWXsbnAngvm2d7vMZsa7Yn36AsB4XnIjFsV+g4XPFmhtKFQWl9TNnIYy06gW/C4iGEJeO4tZpvSiyQAbBvogiLjpH9VW//ameb4b4f44KsKZzA5Ru93JVgHuGeXJipBo7u2PhV04qlrU3kdEpt1mwN32Fc6MvHgW9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e846243-e236-49b0-df18-08dd193813c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:31:20.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj9FAnzNdHTMrlQ8+bBiwasObtSrSaA1cmFa9zBzfOvk3YgJWYHuB0NfHK6ONmlZ9q9hqPhsEdZPbIuDyL2yGRTGv4wraiUwzTjJ0oF9yQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_09,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412100122
X-Proofpoint-GUID: EKKv1JNZei16Cdqyz5u7V6c1_1cfWahE
X-Proofpoint-ORIG-GUID: EKKv1JNZei16Cdqyz5u7V6c1_1cfWahE

If dup_mmap() encounters an issue, currently uprobe is able to access the
relevant mm via the reverse mapping (in build_map_info()), and if we are
very unlucky with a race window, observe invalid XA_ZERO_ENTRY state which
we establish as part of the fork error path.

This occurs because uprobe_write_opcode() invokes anon_vma_prepare() which
in turn invokes find_mergeable_anon_vma() that uses a VMA iterator,
invoking vma_iter_load() which uses the advanced maple tree API and thus is
able to observe XA_ZERO_ENTRY entries added to dup_mmap() in commit
d24062914837 ("fork: use __mt_dup() to duplicate maple tree in
dup_mmap()").

This change was made on the assumption that only process tear-down code
would actually observe (and make use of) these values. However this very
unlikely but still possible edge case with uprobes exists and unfortunately
does make these observable.

The uprobe operation prevents races against the dup_mmap() operation via
the dup_mmap_sem semaphore, which is acquired via uprobe_start_dup_mmap()
and dropped via uprobe_end_dup_mmap(), and held across
register_for_each_vma() prior to invoking build_map_info() which does the
reverse mapping lookup.

Currently these are acquired and dropped within dup_mmap(), which exposes
the race window prior to error handling in the invoking dup_mm() which
tears down the mm.

We can avoid all this by just moving the invocation of
uprobe_start_dup_mmap() and uprobe_end_dup_mmap() up a level to dup_mm()
and only release this lock once the dup_mmap() operation succeeds or clean
up is done.

This means that the uprobe code can never observe an incompletely
constructed mm and resolves the issue in this case.

Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6756d273.050a0220.2477f.003d.GAE@google.com/
Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/fork.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d532f893e977..c2591063dfc1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -696,11 +696,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);

-	uprobe_start_dup_mmap();
-	if (mmap_write_lock_killable(oldmm)) {
-		retval = -EINTR;
-		goto fail_uprobe_end;
-	}
+	if (mmap_write_lock_killable(oldmm))
+		return -EINTR;
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -839,8 +836,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		dup_userfaultfd_complete(&uf);
 	else
 		dup_userfaultfd_fail(&uf);
-fail_uprobe_end:
-	uprobe_end_dup_mmap();
 	return retval;

 fail_nomem_anon_vma_fork:
@@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;

+	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
-		goto free_pt;
+		goto free_pt_end_uprobe;
+	uprobe_end_dup_mmap();

 	mm->hiwater_rss = get_mm_rss(mm);
 	mm->hiwater_vm = mm->total_vm;
@@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,

 	return mm;

+free_pt_end_uprobe:
+	uprobe_end_dup_mmap();
 free_pt:
 	/* don't put binfmt in mmput, we haven't got module yet */
 	mm->binfmt = NULL;
--
2.47.1
