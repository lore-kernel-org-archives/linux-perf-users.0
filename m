Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012003.outbound.protection.outlook.com [52.101.71.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374D22A813;
	Tue,  3 Jun 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963169; cv=fail; b=d01LUIhws41lvrxyMvpWQFetFBZsXhkwdkKqZ6QuJbWnVTRcwLz5NhQZ9siDrfH8rheEPngubexeCFDawRcUfV5Xu2ORNPgSSeeWzPNsuX/9xXHQabe6w0y7TjmAHlx3gkqAahZI4UketoptCOWEu0bPaxfvermAjbF1W6i8elU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963169; c=relaxed/simple;
	bh=vpe3C/qVdeiJhPJCOrW1XWEal7MiUBkRu9dHYWLzqIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TywUMSlW5UJk2EeNMfOFVb1iGIkQ+aW2VHdm9liOLy+aPxqTVE1L2d5NzndDO7K4QglBUOla4/jAe27dQXvAeyX+2RJpubQ1sAFIACYcZ/tzXI1Xbd9wHff8Dwin99kJJUTsn0msYJvHBPn46Ozg5EArM9XpJRyCcl4BkOFiyeU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l4LvCNIM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l4LvCNIM; arc=fail smtp.client-ip=52.101.71.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l4LvCNIM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l4LvCNIM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S6INAqJvPZqn1inuadxUYG0gk0IoMPNJL9lMvc8szHDVHKOtqeIpf5ZbI98HVbTJ2GMuQFECBt9nfe1C3ILW66PpiAyKe6MzIywlbLyiCsltgDZRqBhE8ld3n23iP6BRJiLufoJleriBkx5BvSX6XfIXJhgYkTojL7nXFgsy/gYjj2fJjC0EkdrRy7XtSCxf2iDmwFdERytNKg9F6nTg6dR9JOIQc3sgsa7kRNRi6eGwXQqIH7N96h1hW66Io6IaXOvC1WKjHIbKgQWpH80nPAcFtPVqR0e+BV1bDq1SziMJOt2S1RGfPSKr4D2wf3WreEkFMEf6lT+1N70iAY2bNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFA7a8DWsl5/jyNXuL1kNIobEM6FJw9JjJI+k5owzJ0=;
 b=SihvvCzVcOLf02xuSp667+8K266E277B5if0Iy0+x3cmcjb4aUxhG4k0luAl++IGA2gWUXgpjKDVxvJ7IIjJaXe/u2RdaXTNBaH8YKGCaiOqjy2BAO3m4Ua2e3GED5TNciayF/8kFGImV5RfFTLmHcI/wdtaC9HJVpDf+jvxv4PWbb+gkdPc4OT4uzwAtSTmK4bK6+v9nJsO0Rltd28S8xaGQlRZG21aqXRgQiG1G4N3fre38f3cJdeO868mlaYq+KkAQ00ZxkHeyj0LUkGlg60mI0FzExmKAQMA8U0iVneK95WiNYTDoWp69NZ3uffAGuVskXhKA2HeBiBmfqAZeA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFA7a8DWsl5/jyNXuL1kNIobEM6FJw9JjJI+k5owzJ0=;
 b=l4LvCNIMyf7k77iaEPY2tBLMO8eFsAOe0rRYEagN3Buahdntk34gy00Og+nbctK5t1KxsImxbuKZUdcFsYyF4aMTZOgBogLqlH6cW7d2j9K3Pnq60ZAVKDZARhfk1FcGJgsWhVvpOwmknDlCDHTuJo2wcZdwataZUAyNYrt6+Ng=
Received: from DU6P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::25)
 by AS2PR08MB8783.eurprd08.prod.outlook.com (2603:10a6:20b:5e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 15:06:01 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::4e) by DU6P191CA0011.outlook.office365.com
 (2603:10a6:10:540::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 15:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 15:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Wh3cZV53mAjGdy6N0HqALtThvWnHnvu9a8TpAetVxO1PmxoxFWF7jDZv/+zSfY7KSLxJGvVitkhUU07KnmDXMftO8Ucr0pNhVeNibQTu29Fjc6pEE9B+sI6fCiFZa87fBEygoJoUjG3SR0q7AecdoRf5t4LC2e68X6r0Z2Se3b/0k4PrU+A/4cBy6lSA1VGJ2OpyR3BRd3MdmH1N8XRajNmwEvxjkdYNu2zRB4V+0+ODI/dQNkQkO64N3s6b9eltmil78xpIeAaPwRJVz+/+SATiJN6SWnMNMZlBJLC6GK0NmqyV982hVGmqWWTdpDlPrA8JvI8ysFwFzSbibjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFA7a8DWsl5/jyNXuL1kNIobEM6FJw9JjJI+k5owzJ0=;
 b=vfI+c9Q2gHOnjYG8C6fzmCW5t5I7kH5JtLW/X2VFvUNY0WIzbBp416sjoObz3zSdCQjLZ0XzghItnJU/Uga3JNM7+Yp063Xh8t5JmU1wY58mqH7VhnXGWsyKIiNG0omHVUIWJGd4dCOZf82gpOAECB54wcVS2O3hbUqYK1GlqUzvsSm8nQ0GD5pfVvmuLXl0MJSsxPXrHs3A8fV3dX+NFZEzUtiof6ztWyQKGcwpmieQyHkCVZMeB0IS8ykhCEAUzkmNKF6ib6HGkSSxoqBvSSDGclwO6efqAJbZhpdDVzwaNzO6wPMOvbo6Eb4yWTjrO9RV5vsxdxav4Xw84SgH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFA7a8DWsl5/jyNXuL1kNIobEM6FJw9JjJI+k5owzJ0=;
 b=l4LvCNIMyf7k77iaEPY2tBLMO8eFsAOe0rRYEagN3Buahdntk34gy00Og+nbctK5t1KxsImxbuKZUdcFsYyF4aMTZOgBogLqlH6cW7d2j9K3Pnq60ZAVKDZARhfk1FcGJgsWhVvpOwmknDlCDHTuJo2wcZdwataZUAyNYrt6+Ng=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7432.eurprd08.prod.outlook.com
 (2603:10a6:20b:4e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 3 Jun
 2025 15:05:27 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:05:27 +0000
Date: Tue, 3 Jun 2025 16:05:23 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD8PM7qx7vCDhs8a@e129823.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603140040.GB8020@e132581.arm.com>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7432:EE_|DB5PEPF00014B92:EE_|AS2PR08MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: d30cb376-5b2b-4d3f-f665-08dda2b02698
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?6aq14Qww/3jQqHR+JLwtyzDW3c3d9GS1hCUjSdVWUw/x2b+kXwiMrFrgPZuX?=
 =?us-ascii?Q?DUV/S4jACUrgwKyzEY7xfZW1JTswSRv2unVHHuIJKqDqry9PETrKpajOlZPy?=
 =?us-ascii?Q?8QbBvFQtDYEXMtXg510K3D1U9IxtFyGZO47g2RzdDYWNgNIhuoU95faJavCS?=
 =?us-ascii?Q?RzWYW9fU995DGKK1tSztbhROTNtjDQxsr7SmNAvfX6b1tZKDm55gAQqUsfqv?=
 =?us-ascii?Q?7iAoW4sUytLmcm3MPfzGjYzzu1wL2Yzy3TwIfG5Zbg8DZp/BstLEc1eiJMFf?=
 =?us-ascii?Q?X/tTWRjTkX+UqPI1WTBEWel4mJV/ezCgrbesiZ8bS9AcAAenQ+MQEr3NKWuB?=
 =?us-ascii?Q?95NG3aYia89K4c99VWcNiCzozammVgZ11qJLt32PXWlkrMWzCmhwPAUf7nvk?=
 =?us-ascii?Q?Tx+mpwq1NFeF1yWhKgYMF5QsTnGBNAl3vSiUPturizKBaRehJgLY37jk6gGa?=
 =?us-ascii?Q?MIzw4LbSc87czzqmKgjY1elGdtRKUhvLhg6/MjFVGKCbSl0NbobSKctE0sKb?=
 =?us-ascii?Q?PjPh3bzL01gsLo/HSMT5aWeDQmcGAxArVYJujU+Fw5YoEPipdFe+cO+BJa7x?=
 =?us-ascii?Q?PdWQGUyPr9sh3gr8Txv7FqdULzXKEeRd2aKx09lPPMRiYfaimhP7TjSwcHAl?=
 =?us-ascii?Q?V99czXDmduP27U/StBHDyTaDFQHhO0OTgv1GAczwPhXD2xBnhQprCdLOUtq5?=
 =?us-ascii?Q?K69oZP94sT7GUmEEuQB8PBP6spb2kn509kpYiC4dylH3PghSFXFPaDrnkCV8?=
 =?us-ascii?Q?7lYYNy6SxDYxhykVLa0GP2HlD7bLhsiJnjeSz4mjtpYlM/lPYNs4m/xS6RJT?=
 =?us-ascii?Q?g1XPlrSI4ms1dEgpPMYC36KlZDUI9daeJKD6w272T+xzoxukJuWZg35Tm6Bp?=
 =?us-ascii?Q?ztDKCM2XSrMu1dPCwqZtV9QQooSCQ4JOFw++bvhIHq4O8jQZd2ANVEfOUozm?=
 =?us-ascii?Q?cZFVngHY5Fiq060DoVg2HiFGYVuC3qmctw0HdbIUWK2Gf7B9sbTVb7SON2j1?=
 =?us-ascii?Q?VT3SHSbMbTqiobrL4VWlN3p4bnvsnVZU8b5xONaSarCc4pMEZ77E9XEEZUb6?=
 =?us-ascii?Q?eB8Eaex6nn+drM+QpcTqojDBr6FM65cLfIKM6H5pQWH/66L44LMwvG7LwUgQ?=
 =?us-ascii?Q?YhL5GTR+v9Wlpr6ghZc8ZdJ6iPCYXFxWkW/KzQULpg8Pbt11elPm9NoPC1hy?=
 =?us-ascii?Q?NswtKKHQUG7RBw+/qHQfIbmMMpfKPVISRpZBLdVV6CsUcCiwxY1iWy1AnaH0?=
 =?us-ascii?Q?BJ+zsJ+hVPQoRDxHCGg5h8ulw2MisA0F10BaMWghxolnkhRCMhxePG2h+7I8?=
 =?us-ascii?Q?i5k9VS//FST7SNCghPWLJtULALgXt4S02WXHjCy4DrzDW0p8EeCxOYxFdDUI?=
 =?us-ascii?Q?T+2bMHM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7432
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e3bd53a9-5019-41dc-2f75-08dda2b012ac
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|1800799024|7416014|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqYL0ze0HfjMVHMyzjmUf3mxzUr+9RraTZnVuzq6Z8zkpnBZWhTJPXWcqH1z?=
 =?us-ascii?Q?WfFQtGw7L07hgg3pWL4egh3ktqXtuo2axhonK+VSAh33xHPRIsLthfFipKLl?=
 =?us-ascii?Q?CEVAuOKXqTbLw9BGhplG1mT1tJYMndEpV3WzN6OBAG2M7KaS3fNjDZB+qYEl?=
 =?us-ascii?Q?6FMW5V2XA6n/kbWaSpmE8Gzp4jqBPSBVENVeKIgKddpfTBnhQ+fWCYEPFMhu?=
 =?us-ascii?Q?hwUf3P24lC/ZiBD1nXFVlpgSXPQn5ueQOC8XBsiqqtLi2xRcoOmERJx7Z2zM?=
 =?us-ascii?Q?wZWZLXcmB+H6KURaIJR+AaET6tEoY62m3rQ2AW6onCW5Kmp/D/tyj97IsU46?=
 =?us-ascii?Q?ygoxtXhdNqWn0WMubaEMgfTKx/CFRryMk6uqi/TfAlMy5ewylOESQgqtkuwe?=
 =?us-ascii?Q?+hhCMYWPeU0OfoItH+cQPP1uBkZ9+fnsvBrOl0Re93njoneDduKQclHpI4Lx?=
 =?us-ascii?Q?UCuepL7G6qgjvMlLZRjGABv+xDdBPFXT2zp8vK/UmgJBq/zmkenEPgu0XD5t?=
 =?us-ascii?Q?V35sjycndQG/SnfRyogQab5GyN6TjTB4qjh8wtVzADnILxbAKW2r7UhOi6Wu?=
 =?us-ascii?Q?6BTBhqAUpdT0N6wPvpw8KgjQHH+TCsKwgjOLOOZEJT+UekLS2QYpsfZyFf+Y?=
 =?us-ascii?Q?MIgKh4Ih+0NQxKt186nnO9uEumEzEYOukFAReiBqUcGYvfVQSaF0El4aY3L5?=
 =?us-ascii?Q?a2HNrIs6OYpvqZbq7mJdqFAe/T8fJql1/iK6+2L57MpL+qPZe7ZWvb8V2buZ?=
 =?us-ascii?Q?KHw7V47rhopkBlY1CDIyAzqLGAjZ4KEFUlIgxwuQliAXa2GT7nMRJC96jdqQ?=
 =?us-ascii?Q?VjKlRPdeTJBnvWPdV5WRa7wiiwcIhnKYZXr/VF30N81ZWxQpOH5VtROFYN/+?=
 =?us-ascii?Q?Bn7kmVhsk7B2QHe2ZS5rijPbjHdJPWYdeoC8HzNWnr4nTLzczVw31j8yyp6k?=
 =?us-ascii?Q?OQIa7TRMERcSte7zhpWeoDE/iP+b0hHY6W6zSo4E65slE4cFM2CshB1zMKTC?=
 =?us-ascii?Q?a8fy9hsTkOi7antXFvoqomjXyNKVd7DACMynSWjd/bDEFhhIiph+G69niY0S?=
 =?us-ascii?Q?UV98n51tXc74ik7h/iRgtNc+bRlkOf8SNqm1rDpNqTLZuvuALUwfbCGaK6+S?=
 =?us-ascii?Q?ia7q/SM5DrUVc/EP3eCwgG5eFA+vJJbs5dvmsVcq5/9hm8ZB6I/nXNnntOw3?=
 =?us-ascii?Q?k468tKgExkjS/kmOYsCAD06Mg4viJqfGq86ZHAmowKC8uZm8DZBSa2MfX4wl?=
 =?us-ascii?Q?EvsQpOHZXdWEKPchpoodvlpt5R5QiVE06MgkzdUTPzhWigbaKVWc256vVzzQ?=
 =?us-ascii?Q?n/d/+qbC9uJzt0aUulUNBsFJnpic2cdA6pEkR3QgCd7kTRQ94X6DdHdosNF3?=
 =?us-ascii?Q?ZQSzCAu9l9fKQGN+6sAq4hYF17eR5Tbv/mEpiHv0zA6IOwjzl0Xm3nUPrNfg?=
 =?us-ascii?Q?Fa9105eHSr6chUqqmrcVSmnd5CungZk7Min8sxgGL+w3PRxrNuczbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(7416014)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:06:00.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30cb376-5b2b-4d3f-f665-08dda2b02698
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8783

Hi Leo,
>
> On Mon, Jun 02, 2025 at 07:40:49PM +0100, Yeoreum Yun wrote:
> > commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > changes the event->state update before list_del_event().
> > This change prevents calling perf_cgroup_event_disable() as a result,
> > cpuctx->cgrp can't be cleared properly and point to dangling point of cgroup.
> >
> > Because of this problem, some machin meets the below panic[0]:
> >
> > 863.881960] sysved_call_function_sing le+0x4c/0xc0
> > 863.881301] asm_sysvec_call_function_single+0x16/0x20
> > 869.881344] RIP: 0633:0x7f9alcea3367
> > 663.681373] Code: 00 66 99 b8 ff ff ff ff c3 66 ....
> > 863.881524] RSP: 002b:00007fffa526fcf8 EFLAGS: 00000246
> > 869.881567] RAX: 0000562060c962d0 RBX: 0000000000000002 RCX: 00007f9a1cff1c60
> > 863.881625] RDX: 00007f9a0c000030 RSI: 00007f9alcff1c60 RDI: 00007f9a1ca91c20
> > 863.081682] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007f9a1d6217a0
> > 869.881740] R10: 00007f9alca91c10 R11: 0000000000000246 R12: 00007f9a1d70c020
> > 869.881798] R13: 00007fffa5270030 R14: 00007fffa526fd00 R15: 0000000000000000
> > 863.881860] </TASK>
> > 863.881876) Modules linked in: snd_seq_dummy (E) snd_hrtimer (E)...
> > ...
> > 863.887142] button (E)
> > 863.912127] CR2: ffffe4afcc079650
> > 863.914593] --- [ end trace 0000000000000000 1--
> > 864.042750] RIP: 0010:ctx_sched_out+0x1ce/0x210
> > 864.045214] Code: 89 c6 4c 8b b9 de 00 00 00 48 ...
> > 864.050343] RSP: 0000:ffffaa4ec0f3fe60 EFLAGS: 00010086
> > 864.052929] RAX: 0000000000000002 RBX: ffff8e8eeed2a580 RCX: ffff8e8bded9bf00
> > 864.055518] RDX: 000000c92340b051 RSI: 000000c92340b051 RDI: ffff
> > 864.058093] RBP: 0000000000000000 R08: 0000000000000002 R09: 00
> > 864.060654] R10: 0000000000000000 R11: 0000000000000000 R12: 000
> > 864.063183] R13: ffff8e8eeed2a580 R14: 0000000000000007 R15: ffffe4afcc079650
> > 864.065729] FS: 00007f9a1ca91940 (0000) GS:ffff8e8f6b1c3000(0000) knIGS:0000000000000000
> > 864.068312] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
> > 864.070898] CR2: ffffe4afcc079650 CR3: 00000001136d8000 CR4: 0000000000350ef0
> > 864.673523] Kernel panic - not syncing: Fatal exception in interrupt
> > 864.076410] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xff
> > 864.205401] --- [ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> >
> > To address this call the perf_cgroup_event_disable() properly before
> > list_del_event() in __perf_remove_from_context().
> >
> > Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/ [0]
> > Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Tested-by: David Wang <00107082@163.com>
> > ---
> >  kernel/events/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index f34c99f8ce8f..909b9d5a65c1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2498,6 +2498,10 @@ __perf_remove_from_context(struct perf_event *event,
> >  		state = PERF_EVENT_STATE_DEAD;
> >  	}
> >  	event_sched_out(event, ctx);
> > +
> > +	if (event->state > PERF_EVENT_STATE_OFF)
> > +		perf_cgroup_event_disable(event, ctx);
> > +
>
> As we discussed, seems to me, the issue is caused by an ambigous state
> machine transition:
>
> When a PMU event state is PERF_EVENT_STATE_EXIT, the current code does
> not transite the state to PERF_EVENT_STATE_OFF. As a result, the
> list_del_event() function skips to clean up cgroup pointer for non OFF
> states. This is different from the code prior to the commit a3c3c6667,
> which transits states EXIT -> INACTIVE -> OFF.

Just for correct this, prior to commit a3c3c6667,
Isn't the state change INACTIVE -> OFF -> EXIT?

when I saw the perf_event_exit_event(),
  perf_remove_from_context(event, detacg_flags
  ...
  perf_event_set_state(event, PERF_EVENT_STATE_EXIT),

So,

  1. event_sched_out() -> INACTIVE
  2. list_del_event() -> OFF
  3. perf_event_set_state() -> EXIT.

Therefore, the final event state is "PREF_EVENT_STATE_EXIT"

Therefore, I think calling "perf_cgroup_event_disable()" is called
as soon as event_sched_out() since commit a3c3c6667 change the state
INCATIVE -> EXIT.

so, the middle state of OFF is gone and I think this middle state "OFF"
doesn't affect any race condition since the removed event "wakeup" is
also called after it changed to "final state" -- in this case, the
PERF_EVENT_STATE_EXIT.

>
> My suggestion is not reliable. Roughly read code, except for the
> PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
> up the cgroup pointer.  The reason is I don't see other places to
> clean up the cgroup pointer for these error cases:
>
>   PERF_EVENT_STATE_REVOKED
>   PERF_EVENT_STATE_DEAD
>
> Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
> cgroup as this has already been handled in merge_sched_in().
>
> So a correct condition would be:
>
>     if (event->state > PERF_EVENT_STATE_OFF ||
>         event->state <= PERF_EVENT_STATE_EXIT)
>         perf_cgroup_event_disable(event, ctx);
>
> And we need to remove the perf_cgroup_event_disable() from
> list_del_event() to avoid duplicate code.

If we sustain perf_cgroup_event_disable()'s call in *list_del_event()*
But, Should it be? I think its enough to call as soon as after event_sched_out().

>
> Perhaps a better approach for code consolidation would be to modify
> the conditions in list_del_event() to ensure the cgroup pointer is
> cleaned up in error cases. However, I'm not confident that this is the
> correct direction, so I would wait for suggestions from the maintainers.
>
> Thanks,
> Leo
[...]

--
Sincerely,
Yeoreum Yun
