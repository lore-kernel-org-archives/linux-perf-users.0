Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C218C93D;
	Mon, 28 Oct 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105650; cv=fail; b=UBBxj412Yda+JUYtH3UQbKprxGdN9TY0mivmZGZQvg64fybL323CvhPw1pULdbvtrNmMjQGiyKHU2Vmm2UCgDKJIjNHFuyY0oPgIdgqQlYCZch0Y94rN5/PmQ1xdAvz0UhhqP4EKomx6aD5xmsPT6rcgshX2oHYYdLR4/yoxtt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105650; c=relaxed/simple;
	bh=PeCalY1Kq/wszz+WQuhN9bFZwPapcCxhDYTngrcgNPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWYHrFrRc0exM47C0k/9F+ymPMnCcxW81f+6oWCV8nyffQ85b0gZnc/NIKimsYr6rcKBwTDYGe+KFYBDjOGGsV2IfYiHP8I/GCZnCL8gocOwxNdndynElIdK0OpS9cK2alZ3wynNn/2CJZUHC2fgDMj7vMq0XMdYxiKYthjoZXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tv4vvJJ0; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tv4vvJJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy0qulPyPGBdSj6/Vu10cSBi3RigJSTDWOGseK2v4W+NUFavDS4IA+gCcQYzNeCF5vQMV2F0YPHuAFbJPXXcAqzAtaBW1mvl9lt7Cmk8RQ2adZj9N7xHWq109vaotb+wlFTf53zwa3kpjx66bUZHV7mx5rsesRONEpW3NnMbCRfOMZL9WfgRH3b9AeltPcITBCabToWpIYqt5FfqlVUEF2KPzOFz4EWOJ9oBqxoayP6PAlReqSOSuduV32ujM8BKnnkZAHYV4I/wepmkO0xp8qycS5nVWU8mdagWSkbny9XSo0huP3bweIzbngVoaGgz5M7UX2c6bapF/ZMat+DAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP7255aRZdK6rQhpwsoHLsBUQNWLbVDZqiWmJTqk92c=;
 b=M0d4tnhIB8K/J071xNjo9VxHqdGshrM7MfZm/KJSa1DWwl6LLAGzNQXMVoGuBrOv8xNBCpagytN9S7DbCA5SjHP+dHNXb0LZknZw30dA96cFMyyxZ/vvinkqvyM69QK+iCd7JketH61+QFp5T+scrjoy8kr4faxHKNyIvWNoo/fMwcMRQ6MvZ9TFJk6dvASGtGK5dSsB2vy1Rx34t5Y3sSWwgfRlZY8G8oOMFSH6HPjKTnDoFOs6aF989BpqS3KO26xfoP3bjcDNYk+Ppxny6E9cCX5k4y/k6uibajLcyNsRS+6RceU+9sQmSaI8CKn4sPwg0plXFuDDBxsRD8Z1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP7255aRZdK6rQhpwsoHLsBUQNWLbVDZqiWmJTqk92c=;
 b=Tv4vvJJ08XbICD8YGYgH7mBcbx0PB4Vj2bC0BYaQLh0e3vWUo1c6c23lYtcW0SZVz8wFtNuEDRRq5uCgls3myavjKIlZpWKg8rbEqjQBd9vx7hw6IpWb7xXqy7Gf7xu9+mzKtN7ZTK1yh59pWuHPEH9Ym+Vi2x3skWvePMNlbpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 08:54:04 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 08:54:04 +0000
Date: Mon, 28 Oct 2024 14:23:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Message-ID: <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: d946e7c0-9c45-4f8f-cc49-08dcf72e1315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCWSgiERj/8llFRmIpTmAhGy7FHuQfsm4hPJ6bu8Po2Xah9oGg179NhHAj+L?=
 =?us-ascii?Q?HiC58Z637xnFXNnkN2H4vkzyyN6uvw2/eFjNSVTApD01MzdDl9gy8ogvlyUE?=
 =?us-ascii?Q?gVPsgzHoN677l1o+YYJoxGmye6gHKtJ0iX7NfZjXPQCaQY80MHg0SedLPpbc?=
 =?us-ascii?Q?Zgj+Gf21xLJ63SklJkMnTZTkE3eZmU30JO0YDESQF8T9vePQngZjLI6wAq6y?=
 =?us-ascii?Q?koJ9XQ86+6ryLPnaf9ymmurbOdOX5OSWVmvAce+4EcGCKKeRo/8hq+O8fjkO?=
 =?us-ascii?Q?ys25lMvkJZmlZlrjFIDmuSycHU9bxSRhd2LhLba9ggblr7lQHgZrusGLjq3O?=
 =?us-ascii?Q?gKHN617VrIPo5rYrcqMtHIHpwIHeLKZ45Kl9PDSs7vBKDxVfiNFSSygkTC1w?=
 =?us-ascii?Q?y8hdARIRszKh0ijBWcHbAkvZVNr6PYKFhWuD5WvHY4BD4XOyzPJslb2z0SJn?=
 =?us-ascii?Q?PCmYN5QljriOmBi6dgg7Z3gX/vUb/eeOP8p3rjU8BxhuENfrJTLBprOpoK/G?=
 =?us-ascii?Q?BYLQ9PFNj7rhxDdKVVLvXp3LG6bZ7xMW3h1AwVDnjoG5EIEPoGu1GgW1nBmd?=
 =?us-ascii?Q?Ljeetqmk5SRklPF0kdARQjzSYdpubHB4C0BHbrTrGaf6BvjwyogxX7tl7FAI?=
 =?us-ascii?Q?ekLxj5a78mtghormqXCZS58Kx+XAlizlSv0UD42qUe04Tj3Eq75pMwp0zPOW?=
 =?us-ascii?Q?ImC90zKyZAb/qHtthWBuazQZZNIVLJIZ08UXYGuKL9LEj258X4xX/ifrTH17?=
 =?us-ascii?Q?p1ICkttjDieiAfR+xonWOuFa5q95TilmVFyNGpsB9CRkbO8O4+cs87BjbNAn?=
 =?us-ascii?Q?58Hq9dnRNl906j9BOi0ATZP/u5Nm1zDQELUqvCnruiSaX7xkdShvBLVvcQ5J?=
 =?us-ascii?Q?WY0/mAHc8Ms+Nz6rCJgZCzMRvgWqjcW3BqKi4TZhIf2h0oJiBz2PFYSn6APg?=
 =?us-ascii?Q?fjPcJ13z/5P2t+JrrkSQP1CT6zH7AwUiZ0V7T9hb7y8GUoQRxIoMOOTx29iQ?=
 =?us-ascii?Q?smLHZlCYa6SwlIjie4RnsK0kYYgmc2n+2flC4GmJft1fQx86yuHRY/VGoXrn?=
 =?us-ascii?Q?YxGNXwJo36YAdzizcARIRomEfgtkArtCTGbUK5uSsiX/IL+TtXGQGRntm3kM?=
 =?us-ascii?Q?TdvkxZlTlJziQj0c5DBliZ1jEIXPEc2jbBujmbKnDraGGR5QZnF5ycJcvaIx?=
 =?us-ascii?Q?ClvtSUduapvEFxV01Beyt71xy6KK/NFocQFI7i06y7cpSR6U83zNbL/YqrYc?=
 =?us-ascii?Q?as8X4MImQ/iLsgSQdzooE13qs/HwQREJWrUY+Vg3kl9WvXYzoWZ1I/q7AlI7?=
 =?us-ascii?Q?JW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vTcbhnY0ujkxNdI9eNby+1WsnOYkn8G/kpF3sZSwF8ioh16Yz+n0FpJ4jWK?=
 =?us-ascii?Q?+Lz0xWYM6apdDoD5Uy9SNmfH4MOXTFrsZ1s8g0yrQAHh9GmfqwNx+u0nuyXB?=
 =?us-ascii?Q?rYvGTeVZGZALgfVzKMrf5f+Xfe36hcoWzTQOlvnJsHehJ7ch6CYLFCgjuQ7f?=
 =?us-ascii?Q?nGcoqAFt5RUxC910NSSydjQka4GfjmO6IdrGb0mrXs2kxmr/tNZ/ON2lAqEn?=
 =?us-ascii?Q?dCjChX+JAA2xASrTOeV6pakjvVaxOmaiZLH+3W1n7r0rLJvo3GXsYUe9QHi/?=
 =?us-ascii?Q?9za5dSHNw/yYSPm1LGV6Ol8mxTzUxKO4dYj4saTJxnzNMU0pY3qXubBygiVO?=
 =?us-ascii?Q?M/Yd1vw4X7HCsR4iRg/IySrAlccxKX4XjiyhQTIY2K7DzCiFptiliOWEKSEo?=
 =?us-ascii?Q?ObuIpar++SwqJuJPpfdjNie9wW+YPzJLxF12vdWGrdkkvxab67aCKaX+xALM?=
 =?us-ascii?Q?+jNZ/eUC2bc1Hw+DvdS7+F30XviwQCHi05Z5jcHZCgQy0R1ZPZ8i/kfjFUWv?=
 =?us-ascii?Q?iypAZOO3FZykI1ubyxlN/03qnbmS8EYJpyIuNjotoY4O8vK9SA/NUC1fTmlr?=
 =?us-ascii?Q?6sK+CJd5UsQDw8S4tm6yKGD2mDC7tWyuJAwjHWEkJeK9ukfyPDXZWNsULL44?=
 =?us-ascii?Q?vrhQlk8AWpaYuDAp1ULJYY0BzMZzzxCEXbsb5mkMrwgxh5IuRzaksSFOJRb4?=
 =?us-ascii?Q?LkthoBMWAk2x/S17mHnaOAR3n4Fai5gv5/968KxTsrkaOXk1d/pUPVq/O4eP?=
 =?us-ascii?Q?MprrwY3KYUUOF8TMtDrofaDK4H3C37aKTA6B+VizgvI8lceUmWFR408HuUY4?=
 =?us-ascii?Q?5FcqlWNckYnm0P3QbuftEWphWkmf0KDsglCi77iWalJ81kZyPD7Ddty4dVRM?=
 =?us-ascii?Q?CBcPN006H7Xp0YeIPTwazgyb7EEb7cfHc77TxTsVwVz05rg/QsCLaN8FFO9Z?=
 =?us-ascii?Q?At9y3TTm22yeAAqPy/QM85rSf5YWc45BuPf+neN3vwaViG41d3uay2wvIxaA?=
 =?us-ascii?Q?jQt8ewnhDvXiC9jahpMh7cqmatcKNVRhpO66dn+X8SI71rdzF9MA0ZSpR1xT?=
 =?us-ascii?Q?ZSCRooQuxegOJcoSiYGqiOUP7ql2dCe1I0RqQORN1ne0He56jlyQr/gePITF?=
 =?us-ascii?Q?/rXffSncfls0nho1ujiv4OAvetPBBOrf/KfXN/S8A5Ep7FvsfjNKepr5ksVl?=
 =?us-ascii?Q?F7p4gQp4DxeUzRk9KCqpsIpuvc4jGk/XYVF5RelAiLao4xLhbf0WQ/uo4mFU?=
 =?us-ascii?Q?1cn3mEt6PRzRhWxa6l8DJFgFmM80jfIfv4vPuoX8vuUr1RFd46mCYV/jp6g2?=
 =?us-ascii?Q?l0W6KMsLrbWXxbDpWE2cFCc5lh5ebjFnlsFBu3SQoJuB/n3HltP66erU9pP4?=
 =?us-ascii?Q?IoJrxXx3M+qRFmwe366qqzxClSIa4QghkA94A5rhml//LfKQ2it4Y7ZC01AF?=
 =?us-ascii?Q?i44JDSA7+kiWcy2R7o9qzShFkwQrC5cstisTT0eijWSa8dBeu9rw46VeU1Ze?=
 =?us-ascii?Q?B6rBHB6Sdf66EicnwVuTx+Gz8Dp+r99cDFDPpeXphB2wGpZHs1wqvlq6CiUc?=
 =?us-ascii?Q?MZRl9yjX+Z9+9Xbgust4+E5uSbQ4excMhjCpra1y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d946e7c0-9c45-4f8f-cc49-08dcf72e1315
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:54:04.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMQLGo+cZSON0mfeefztQeLgHPBshli8G2G1pieKC29XBc/MxzCoDLL/1u6CknW23gHo9cyMRAvg8LUJitKhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

Hello Dhananjay,

On Fri, Oct 25, 2024 at 11:13:41AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> Post which, one CPU might be mapped to more than one rapl_pmu
> (package/die one and a core one). So, remove the cpu_to_rapl_pmu()
> function.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  arch/x86/events/rapl.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index f70c49ca0ef3..d20c5b1dd0ad 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -162,17 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
>  					 topology_logical_die_id(cpu);
>  }
>  
> -static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
> -{
> -	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> -
> -	/*
> -	 * The unsigned check also catches the '-1' return value for non
> -	 * existent mappings in the topology map.
> -	 */


See the comment here why rapl_pmu_idx should be an "unsigned int".


> -	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
> -}
> -
>  static inline u64 rapl_read_counter(struct perf_event *event)
>  {
>  	u64 raw;
> @@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>  static int rapl_pmu_event_init(struct perf_event *event)
>  {
>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> -	int bit, ret = 0;
> +	int bit, rapl_pmu_idx, ret = 0;

Considering that, shouldn't rapl_pmu_idx be an "unsigned int" no?

--
Thanks and Regards
gautham.


>  	struct rapl_pmu *pmu;
>  
>  	/* only look at RAPL events */
> @@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->attr.sample_period) /* no sampling */
>  		return -EINVAL;
>  
> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
> +		return -EINVAL;
> +
>  	/* must be done before validate_group */
> -	pmu = cpu_to_rapl_pmu(event->cpu);
> +	pmu = rapl_pmus->pmus[rapl_pmu_idx];
>  	if (!pmu)
>  		return -EINVAL;
>  	event->pmu_private = pmu;
> -- 
> 2.34.1
> 
