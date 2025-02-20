Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56D262D39;
	Thu, 20 Feb 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077747; cv=fail; b=DygSNwiRohf0R3nIk2LhDitvcqEugstpMFtbWDpChzWpBkUIqk7KurXLWBqiJeKmbwggRZKM9f5t/nscidznfQUSWBjgV01iQdh4IVULU4wa34J1zLrcP+Gsw3O2JfV2njDrRhAJ/N/0m0WVT6D45usnA2KJSL0tXNuaN5tIIzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077747; c=relaxed/simple;
	bh=ACxDIzlyWKX/SCqt+4yCoyNVjV2JPvhv+c6Np3sdCUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9hnYSZfyrE1y5qPmWC0kMii3y/crYHeLar4TWk4TfhOPFWbCLoFsIoDrSCbO3oy44XZzpJ/mHa6WxnKnf497CwOfuDjsW1mGcV18OZcj7QUxjhW5TNFV74fwMkI02TmZW46t9z1cFeK3FYTzxEz35gyWJlYy4Qn2QSra2Goboc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSfzApUs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=axvjFhjb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSfzApUs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="axvjFhjb"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMfJ9012892;
	Thu, 20 Feb 2025 18:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=; b=
	YSfzApUss4V77TM/wjth1h8hUJc4Bn9n5lOtR8OxjqrVncW6ObJslV9H04kFqXwZ
	y0GNe8AHVmUk4uhEHSyQbuZjgvZ+/G2/3UfYYk10RgP/L5DQkHRvI5wGq7NRtAB3
	1PE7vWhAQvhsnbFtaTPKf/86HVxXuN0DNN5UDGQdtmN3Cil31qgloWRR3AxaVzjV
	Mx2WQmsk/RI0B3YTMxujmqU1Z4ONWothqQ6yE85BIzVAfBq4CIUgmVbkl1YglbI+
	8T6/a8AUta/TJnog/WZCQhIk+jdMgUuTyj9r30MncuwY7hE1nXhOrpiy6QFT2ETd
	BvPVu7s3pm85d5AxdscP1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nmtcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIUCN1002092;
	Thu, 20 Feb 2025 18:55:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tnm28r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCAr2ced5e+HGsRMTEN/u65GYmETZj61+BxJLNcY7jzd19vz7KcniF5DBLpUReKQ3giOP4fuLzpeds0m76dmx6kvhcwhT9l+yQdZikhlLo4tp0lazvHLuQ8EiwH/eO9J6IF7f+SThX87snUsBun/+8TjLzRtSKYYFphA2xt0gZ55W5lNVA9V5IMrNn7lFZSNeDR+9RYE7LZyhcw3mXFrHRsIr4LGPAoSeodDVdYjvClj32GyIeWDsTtTb3vxZKOia8kUuGRmwFENYjqfEs30YZRTKtinyfeZRwaMfWevS9pgubm7i05caIW39Pu8QcsMpk55jvrpdmiAEf1XrCp74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=;
 b=JzcooUy1LVk5l/qvOOAvnBERwEi1mc6nRBtcedkdhLdMAXNgobI6Y4o/KzCK4QHslIiMBaY9ap1I1F9pw4rPIDnbNzngvsoZpBvdyCceqN9kJaXoUpRuwVyvejaKXSJZ5LrtoKadg8AtE21eMzBTupxaqncFeWDwKgY1xnHTDTMGtPoM0OsVdjhQ7G/wlg4Q7CRj76y/7Vh20QD2vdPmnsgMZ0HpG+Kw2YnLZEHGpy3XcBZofME25xCu8pxx32dLOIakBiixjdYToiDoPwl+CdXEa/MRbDHSquYaQ2Y2bqlvjDCQuhs9h9bV2ajiLS+bblSglqqKamKYqXA6GGWt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=;
 b=axvjFhjbkdSSbNvshrXJdWVC+Vwi0V5gh0CO4NILd7VaL9LTzRHTkU0G98/8nu3sH+Lu4PShfxA1tYj3zWIhUCcHBrnP92yrjrWXhIXIPNQUMwQoIcgoif/rgG36t6KVrplFqmnkIB94tS4Nfp+rkusbIXBxaeu3yuXSRRo7SbE=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:55:30 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:55:29 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/3] tools: perf: add LZMA decompression from FILE
Date: Thu, 20 Feb 2025 10:55:10 -0800
Message-ID: <20250220185512.3357820-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0407.namprd03.prod.outlook.com
 (2603:10b6:408:111::22) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d4699b-bf7e-472a-afef-08dd51e02558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZDjkLaWjLkooCqRVWHtyLq0u7yD/l/BEidNCU4dLg8qQYnNckz4TDQ7Dpaz?=
 =?us-ascii?Q?YSRLkbnIau/QdUTll0mnDsy4E7Cn9bJ7b0xyNsRSn9xeKWUGIuX/RRanyML7?=
 =?us-ascii?Q?sgHAeqYrkyIgVMpkAArC2uyCuZqZETPko3d97BThzvapdsIOkwYXErAMA9gL?=
 =?us-ascii?Q?2NWb8Hfi5OhKuzZsJVrXj7zXS3ye5QxNqnOs0xOZfjaEIi/+LVJ2idTnZ7Ne?=
 =?us-ascii?Q?pnaLJ5c13bqxJsn8OWpBHf7nF4WN+21DmO/SYWOZ4PfEoe+s8UD8DZy2Ors+?=
 =?us-ascii?Q?HtoL4kZrURelsgbfQkN6DGFzkDN2APPmgaDm0d9KllpHhcirYO+JRT1UsbDF?=
 =?us-ascii?Q?vwXFUM6YEorhygpDdaDXZZnesKwWmA8bln1RA8GhW3MM8OAWZUDmJ0SjRt2z?=
 =?us-ascii?Q?k67B3vZE7O7u3Wb0wYGFlqRCXHk9qWG8ccJJH0NntFzbUj0nyDHNbkXgDt3J?=
 =?us-ascii?Q?TlhooZgGr2t2b2+EdXGFrzsJ7ZywKV4owaff1FCldnw3n9as00DDC8zy4Eq0?=
 =?us-ascii?Q?6BMyd+WFgkOoAAEKqh+wjTUxULuF1eAxA9unvYoT+wWsl2UqenT7OhEqJgId?=
 =?us-ascii?Q?xQ4JW94R2YfMjF0Ng2vtiDbZqtWw70fYY97iPrnGMRJ8XlWQaaFIBdu9Oveu?=
 =?us-ascii?Q?JPsyF8duc3FsYOCTXt9GMsLEQ+8RKZCk7KXBzJwHbMrVCsPHP/d22C4iWE6c?=
 =?us-ascii?Q?S5+TG+TLPr6b39iTQTK3OxHHShxC0rNprvLVXmy7bLqnanjdlWq/CKhEErvK?=
 =?us-ascii?Q?h2YeWIon4gTqj0Y31EsrS3QywTjuK6aKqSUjY929bsCR5VfPrkde4/ozp7Gw?=
 =?us-ascii?Q?zNatrEbb/t/nVJUwE5YHJncgNxWsFj6BRPmf4NXrMjujMO2NMED9nqNx/MXR?=
 =?us-ascii?Q?N00mgn0mopsmzvqbeRmHcq0Bp7GwszxhwtyQf1/n9TlQJimugN7Li6ZZPui2?=
 =?us-ascii?Q?VPlcezC2J2kImOdsMJYmwB4kMgZvt2dtwYrFvfudIbC7cP0QN9+uCvzqac+m?=
 =?us-ascii?Q?zhdSH6GVzxBaN9Ppn6b7s7fj3ieKoZNPs8ZSMQyaUeoqnX/tdVK+zeRTYEkD?=
 =?us-ascii?Q?iPOnqARJw1UtHdul/A+MYmMiWAzEpJh/wOGE6WXQVvYdKznRdUrtpNqi9WHp?=
 =?us-ascii?Q?j105qeEnMuhSGbU2LctfyFAoLaecSirQPY+zNUeWxmlASXfafcY1XMsuI5rd?=
 =?us-ascii?Q?WbsnAwSl6F5xyszL9+dcKQnsMVhKDwK4XklD4kksfVuVrO0W2eKyfqKNJ7S3?=
 =?us-ascii?Q?xoy5QG6Of80eKLj58NHvsQqgdT9Wc5rS/5FrOjEocu8NSMxDXW3vSZdRsOtq?=
 =?us-ascii?Q?+tM9FZZTQt0bBabTRrItY7+88LxaPHPZIlUtb9AGa4qmUcmjDyoUr/OYyfND?=
 =?us-ascii?Q?Ns49Zv5e3nQmpN8W2IUDSbNSm7BU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7VJQvH9MruacKFF0mvArnJKDydIZWqJQkkDr5Xj2BiwfKKQcY3p7L/rXLv0h?=
 =?us-ascii?Q?Ex54+lenFuO6YFlGduDR09/53/+n0kvz1fQUei9mywDYGyziQOUW8pOEjgHq?=
 =?us-ascii?Q?GYl/X5tefA36UF2c5ickSLNtZeGrHA/RZxxq4yQZib0AgMLk7G11fkjCgnlE?=
 =?us-ascii?Q?NF6ak6IeHlrGXpyfx/RkEpq9pmsPj2TMxr0FkkJQtDNRqfMQQ3g32O/f94d/?=
 =?us-ascii?Q?kf3vvSc0esbuYsEUYw5uv0NXNHP+7SjjMOpdD6QSQG5rqsUQa0DuoO6C8ziY?=
 =?us-ascii?Q?ulUvQCsE9HHyXt6ki1pvVcMSU7Fg4KFYd84ZOXiBxuJpg8mWp0EQNZsDqkeX?=
 =?us-ascii?Q?M282gd9AtbRrcWJnx6osMJIHIN1SfxRAtj8QkpL7UB7O7OUVt8Y6uKqpoRfq?=
 =?us-ascii?Q?F9MFWMRV57kpSuLovQDSv++tzNC34w/ednNPVhBvr1BUasLU9cwGScukWfhV?=
 =?us-ascii?Q?yTgOCEIf4jpr1QLdp59dREhg2YsbwE7jq9qhE5DzIJzbWJUKUhk+pS2b9tk4?=
 =?us-ascii?Q?EQDYyrmrnT9byq4LsFDW0F8i1E3SG9bIrCkZiY0dtSzdZvkhQKYiWyupsfA+?=
 =?us-ascii?Q?ewHyvX13q6odGciLuj1lPBRhbyIp+ivtMYRyhdpz0QXUfoNeErLtfISB1P2u?=
 =?us-ascii?Q?G3e0ppndPysht5MIb50D8MiHGLKgO6Mk+VXb0mK3n1wbM2Pb1Bo/3/HOxzBY?=
 =?us-ascii?Q?z5HIdGefw1MsVjIzO5+QjrM67r5gIefSLvtv+IPEs32BqZH+erRweUvRLHmq?=
 =?us-ascii?Q?pwH0mHj+piNxb0e/dCIdci/To6EeHRfTmwiBvjzW5VvKrbVzaFpGDEuHXdgq?=
 =?us-ascii?Q?JoLn5jHWq2rrWT1EOHjzHzLkq8OBbSZ4HK7KJYayTwtAABg+dlS0O1nntlku?=
 =?us-ascii?Q?LSifiS+UryNTBsUcQzeNxluH5APUNc0Y+AaC27PbLfOwhCANL4aW0VrGM2VJ?=
 =?us-ascii?Q?kK/CMayOc9RCfvS+Agn3uB/1JFkstbi6dDU7/KMPEC90PK7Q/SZzrHOD+dHi?=
 =?us-ascii?Q?1E0/7R1ZHyUtAuS6CIgJj+iRD4VFeApBuj7FFUl7/DHpG4Jequ53VM2zPAXx?=
 =?us-ascii?Q?8iq5nidOWyzxKZhBe5OzbvoTw1ragHPQkRs1LtRpc701XsyF9ry06c4dtHjZ?=
 =?us-ascii?Q?eOaICG0FfvBgfNta5iS3nb3PvfOJZS+PKBAys3AQI/D37hFM2obCVwOWP8f6?=
 =?us-ascii?Q?wwgIXaWnOFJXCRLB3KL6duoXBc1uDqPeJN0YysxGCvAsemZpCBt66eGI9Q6T?=
 =?us-ascii?Q?ZdCDY2aEsASzq+YhF2jQZdmeNLhwq1aI9+LBX0t+Qp7YOJPqeiMYeLLqMGdg?=
 =?us-ascii?Q?YG/hysPdESGoYGFKoIht0sMrJvxgKHMaVzbOcJ+jyFSC3uQdM1VQp2756hQV?=
 =?us-ascii?Q?7fDzw6vCxhKYaRfm+DXUT1u4TghjAI39O4ujez5Ob6bXg1RVeVeEh2BlPATR?=
 =?us-ascii?Q?K2KRxohmPHEv91MtG5LALLftosqHewgmLtdDDxRddUIv37kCC1suqIjPQtwh?=
 =?us-ascii?Q?YtptyLm/8bO7Z5cuLIwg4RanZrqme7layExXdXyhXxhD/cycpZLUpYTyA5iT?=
 =?us-ascii?Q?I4mMtSXj/nP7UHy7GkUVz9IVK4/FT/+ggHuVRjXL2z9D7dPqNzJ+VxDNYUlA?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f8PYOm6r66CmJAMhc2u9cXc20eP7H2iAAfAKM8g/vHwTSDTuNAbzCUqHHB+wMJHHY6q5CKYSfGEeudOoTnjGLOigMRjMgp7olelTsL48n6ABtFp3lJ2UULPQMbvD1sDREhxURNUJtca993ZtGBpBSHv4VjtmHJiBRJQQ3tPG7Y8KX180vefWFNin8vrM1dSdxhGv7EewDULjzpnR5j9k3EYXGG3sHqy6A4ak7CVJmMNQGlvDAuJr46GkKoJz2kxao/OGwtX9KuISECWUwxEFYc5FMSMaqGUmKycr35I7sMP1QyfoZjtcGsxV4SH6uEyJTHm62n1dETAOzy5FGzsTWSR/N7caB3LyOXmXBUcDjtroHw52wRIMpPZz6VbsZsyY2INTEQwyDiCsYiIvkYFcyfPjChhmGBbvAh7CQ9mYsw+RsfI1gK/syvoR9xuV5eP6Q4wXASFOitxWz7zWjyye8nSaTrKMLk/z7ezRMOLrqlpX18DJk/d9MWvC3CAPFLbPB4Qp+0bh4jVieMc6DKF0fqb9Jyfjf+aQG2zTLbyJxlLlVwmmBZqaCdsXbkdJWiEy7ds8y4hf5OD2iv4qneaVZZgNiE4L263DsmrGrDyJE1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d4699b-bf7e-472a-afef-08dd51e02558
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:55:29.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kb5WywkoXZkKtfK8U+yhfnfDBEX019Qh8etnoIa4ZRyq7FTjVr4lB+zGbC+LlhJG1FGt77Ql4ItJ6G2vXrQeVFyrioKwBlGFOaBs8Dwnyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200130
X-Proofpoint-ORIG-GUID: T2qEBr5hQ1UUh6Zc_ROlWh8K6mCQU3b9
X-Proofpoint-GUID: T2qEBr5hQ1UUh6Zc_ROlWh8K6mCQU3b9

Internally lzma_decompress_to_file() creates a FILE from the filename.
Add an API that takes an existing FILE directly. This allows
decompressing already-open files and even buffers opened by fmemopen().
It is necessary for supporting .gnu_debugdata in the next patch.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/compress.h |  8 ++++++++
 tools/perf/util/lzma.c     | 29 ++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index a7650353c6622..6cfecfca16f24 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <linux/compiler.h>
 #ifdef HAVE_ZSTD_SUPPORT
@@ -16,10 +17,17 @@ bool gzip_is_compressed(const char *input);
 #endif
 
 #ifdef HAVE_LZMA_SUPPORT
+int lzma_decompress_stream_to_file(FILE *input, int output_fd);
 int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
 #else
 static inline
+int lzma_decompress_stream_to_file(FILE *input __maybe_unused,
+				   int output_fd __maybe_unused)
+{
+	return -1;
+}
+static inline
 int lzma_decompress_to_file(const char *input __maybe_unused,
 			    int output_fd __maybe_unused)
 {
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index af9a97612f9df..bbcd2ffcf4bd1 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -32,7 +32,7 @@ static const char *lzma_strerror(lzma_ret ret)
 	}
 }
 
-int lzma_decompress_to_file(const char *input, int output_fd)
+int lzma_decompress_stream_to_file(FILE *infile, int output_fd)
 {
 	lzma_action action = LZMA_RUN;
 	lzma_stream strm   = LZMA_STREAM_INIT;
@@ -41,18 +41,11 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 	u8 buf_in[BUFSIZE];
 	u8 buf_out[BUFSIZE];
-	FILE *infile;
-
-	infile = fopen(input, "rb");
-	if (!infile) {
-		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
-		return -1;
-	}
 
 	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
 	if (ret != LZMA_OK) {
 		pr_debug("lzma: lzma_stream_decoder failed %s (%d)\n", lzma_strerror(ret), ret);
-		goto err_fclose;
+		return err;
 	}
 
 	strm.next_in   = NULL;
@@ -100,11 +93,25 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	err = 0;
 err_lzma_end:
 	lzma_end(&strm);
-err_fclose:
-	fclose(infile);
 	return err;
 }
 
+int lzma_decompress_to_file(const char *input, int output_fd)
+{
+	FILE *infile;
+	int ret;
+
+	infile = fopen(input, "rb");
+	if (!infile) {
+		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
+		return -1;
+	}
+
+	ret = lzma_decompress_stream_to_file(infile, output_fd);
+	fclose(infile);
+	return ret;
+}
+
 bool lzma_is_compressed(const char *input)
 {
 	int fd = open(input, O_RDONLY);
-- 
2.43.5

