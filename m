Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D31103;
	Mon, 23 Sep 2024 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727065883; cv=fail; b=oEJaf/3+AFL8/Y2DW2wCFyYiqb0zpDu9qqEGjYRdzgdVgRP5uzF0CiNJntcRaF5v17gp4hILU7Dr4DF5/MyAuwmWODUTTwJAt7PRvXeZijMQB/Bf6sdAkDcnrQuLnuyPZbmquz8QQLx1E1UilYiHLEBnzbeFJV9voHgn95y3uZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727065883; c=relaxed/simple;
	bh=ANsagW38LT8nHhYhpPzPdpDfWClVw6dugX4vGfTzaaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I+JDfr8R0kwOofQh+v5oGtLRMQaZJk/IjaPSmBDJhuS737TE6GUVDIWZer7LYuocum3KQ9r/Eq1alwIua59wBBGSWBtVnwjrd32p2GPyfSacMoSGwijBBJqIjvAITnKvI8SIQH4bGDM8utsSMQK9CE1+IAaiSM/GKpmXmYpQh2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQ4YJ9Rd; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQ4YJ9Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727065881; x=1758601881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ANsagW38LT8nHhYhpPzPdpDfWClVw6dugX4vGfTzaaQ=;
  b=kQ4YJ9Rdr8asGi8iC3sXHLXHDKLETUxg/nZQ5bKyHjeqkgjnHpCjOwf3
   x7Z+Vgl1iAsghjpGtp4Y2bdKOs7xhwn2mxV/75yHz1WmQGnR6F3rjiDsU
   9YTSWMz93dXMTNfw8dJy3PRW0DdIfZ7PH+Epgixip6O4dKW7FGbaeSL2j
   q2elpxMfuftTejlNnlIXsQDnq8euIF8BKQ5j0hmtlFTO1P34u+8iQsjtI
   fMMQByK1PO3PMEp6EVXv9t/QScZbkMYir7RzhI2iU1t8LZcD8DhAOLccG
   pT3Mjw1URxQ/uq/ZCk+Vmbv8H6BIxcUrwiJ1ag4lZUKbWTzwJiSxP0VB0
   g==;
X-CSE-ConnectionGUID: oS/Tx5wSSbSg1nblAM9J7Q==
X-CSE-MsgGUID: dY3Nw78CRyqjOAVHlh+xxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36581927"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="log'?scan'208";a="36581927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 21:31:21 -0700
X-CSE-ConnectionGUID: jRWdhXURSFiRmzt+2Iw8Xw==
X-CSE-MsgGUID: 4py/7OA/RkiDJWSz4dZVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="log'?scan'208";a="75889081"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 21:31:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 21:31:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 21:31:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 21:31:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 21:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8wQqXsxO9wI88j68E0aNYgNpm9imDLOvWhpQFyAS1LzGoxToETrtNrPm+Y/vbi51xeklY1xEj9uN6+HleUnUN3ipiDrpFdynootlfSLSLPon9ZLVJLzr5eBeOIgoCdI/FQ4/wiBqgatgEGH/Kg+JRdAIJf7e/vsQCJ6Rd6WaeFdHlStYZK3sk7j04XS0sa87E7FihgrVzZwfqtw/oIMu1+HsG0AOKUzRJfEMbFUw/iSmPkkRfTp18aSj1ZMo3hOQfYpJPTHeOcb4QLC53Dlg1oe1j9rRaPmFns8P979x88S/CniiktP5QoGiB5wQEuCCAw+gIUmLCRejqFI5azzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb8SqQCM5Az6wVZhLU2tIudX4G0YI+YpmArOcqPD0yg=;
 b=A/ziX+vE+c4GRG5RTb6f6fD0fsSFIeCrTToXPiMd1F7XiNI2jCwfjNrPpFSPvC3G+cwQba30jlW6Bm7vnA7f8PSoWMPPmcTkKvVEBeBDX+GUHkmeFDMBjjNEB5rYacD7iK0Y8199GCCocWOrxtC1ZHoQKGOW0CBNtJCjQ8TcVg0babaQoFPPAfAhxpr03qxp72NiVeCKJKlqqlSF4AeBqsQGoo7OXyiDWhtA4jsFh3WyCgtlrGbGZCdXIVAiMRMKlx0P5SpdCUGZDVUrkJNlR8y+PGlKfHGLtPMhP3LbB7bfIlMS3V9OVvWLcaeOV17pDo2w+UFoTjwQetTXupIbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 04:31:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 04:31:12 +0000
Date: Mon, 23 Sep 2024 12:31:03 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
	<linux-perf-users@vger.kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
Message-ID: <ZvDvB98DW10Au8lo@xsang-OptiPlex-9020>
References: <202409201525.4877023e-oliver.sang@intel.com>
 <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
Content-Type: multipart/mixed; boundary="wdyGV4FNiAvJ62eC"
Content-Disposition: inline
In-Reply-To: <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 62388fd9-ce14-47f4-baa2-08dcdb888dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A4wjsULp3JzK8W92u6i+zf7Cqc4T0P0Pjyu0xqIAWx5WqtDGVmOClfG9UNCv?=
 =?us-ascii?Q?dFNqGkG5QYXNL2qZOUzuDOIt7lsD52FXpXDeFcIwg6VBb2lZ3JPwYz5Sb/+p?=
 =?us-ascii?Q?affCYGu7JsiovlKFhQiQHFhIvHgzXxD0Y2gBRFBhziySApJVP/HhMO0/3wO6?=
 =?us-ascii?Q?jwJ+kJSh+2ZWyfeNYXAccDMyr8nBL0Lu7j+tlPA9w8GYhkB2zZT46Gowow8X?=
 =?us-ascii?Q?n2A4Mx+LWlTegptt300x265sCwiq6IbF7VIXjWqyl0TB8bAYaxP4UZb84FJn?=
 =?us-ascii?Q?O0NH+p+j+4OKJeqTzZ9KyagBiuD/qO5aNc9jZ0efwZJ5KTWCX2VR1xFxsM8z?=
 =?us-ascii?Q?WoxygobNC9787+zIGO3W7rJnOYsPTgpPyNi9K7+46NxDeq3J3Hyls218cjM4?=
 =?us-ascii?Q?JwEVioN/SIB3qRB0fHJdQue+sUVYL7HW02Lg/2phm/g30Z4oZY7OZ36+vVvj?=
 =?us-ascii?Q?2k7nSoMBy0A4S5OYF3CgBD6eZIyvtvMKh0IQuS/D/aicjBNdxvm0JBTsokH2?=
 =?us-ascii?Q?YlvyIFMFUey+QeuGH/ekMoLCrWbW+h1apc/JCVsQfVLEIenEvlXFSEPJlZLl?=
 =?us-ascii?Q?tje6z5H7uZwB99mPXtooZXb+emdkLOPq/l5YvsUlTTp7LfSoK7Fmlfklgsyy?=
 =?us-ascii?Q?1BMufKW0RjUN4Nvt02ySXdxYWzdOZHMvK24PaTQ1ZF6WoW06yt+vXd1Yc7cE?=
 =?us-ascii?Q?fK/U/cz36Win1VHpyrIaYmXYh4cyO/iQpuc6vOCLkSmiPpAxpfZ7LPZVGTOq?=
 =?us-ascii?Q?V5sL5sib5h9p8wBx4Cu1JLWXwEiQBRhse25hwtLYVtHhyWpZ2ERr91By/+sK?=
 =?us-ascii?Q?rY5Q/Fk+mbVYGW5aFZoBQIgyJXtAKpxjvuSGbW1hbycVZAxX7Geyr9TS1/EF?=
 =?us-ascii?Q?wbx9Eir60hkbclCjihWp050ymUt1ganrDaS3QFZpDMlzlZoT8WszdjCHHPiP?=
 =?us-ascii?Q?c5EIwBexmzxQq03zpV2s9+sQVW8q+0ezw83IvT8iCeIW/sHjGqXFkv3nVGwN?=
 =?us-ascii?Q?ed62cfSz2r2oByaza2jPMRVMm8NFlBqvF2LeWqTYAN0fiqJhgPDXR3v5/LY9?=
 =?us-ascii?Q?b4g8ND4j2h/Wvk+8y9kgk5lffRiKoJdLXhmpRkfA8Q62LMLUGogIMPXjvg4a?=
 =?us-ascii?Q?eMBQeZFmWWbe+D+nBfkMusg81lArMHBfbf8IdyKEbu9ZSNUeKHVyL7h3FbE4?=
 =?us-ascii?Q?htcl8FJAV2qhskV4Lev/JpDo+CuvizcOq2U+5wonL0191WELgzXjCCX9lZUz?=
 =?us-ascii?Q?KjuYzEVw5z1w0VHOBSL5bc6M1dogczc8n3juqTazDMerepzzYq83M+h+ORSa?=
 =?us-ascii?Q?XC9bqvYXTd3fk2jH/2Cuwj/Cml7KDYTA7Lt7GzfgkWlLrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DequulURlG9/lXKq0hYfsbHMq4JUj8VYJKDcofZmjRD5LqlvzgyXJOhD6pIs?=
 =?us-ascii?Q?WdZYOs5mgPe0ZGJm0CCH7dXZ1lE4okqPYy8+B7KUzSIJ1n8TCz7970jO13X6?=
 =?us-ascii?Q?lacQ5gVUZidl2aU2FIurhj4s/lBf9XV4A8mquBcdxoUaBaPr2pb7E6uSGOjn?=
 =?us-ascii?Q?AFOW1IY77ul6Z6OkswHXBDh8zkb6pZc2GNxS5S2AjPPdKKbbqg+vQjiAmFe+?=
 =?us-ascii?Q?n1WWxAgkHeQ/IKUR9BQB989bs2L+FuPdyrByqQyqO+vvZj3PaGlib/tJKqhX?=
 =?us-ascii?Q?swlzFYeaOqa2927xMrXiJEnXBiQLxrS8Y1qaBhXjS6wwvlJVfYnIGgG1rYra?=
 =?us-ascii?Q?6BtBC2/59KcA94VI0dZn31jFytSaTRqglMnUScNi5RivJ+OVLkfPVqo0Xvfg?=
 =?us-ascii?Q?VOhd5gxl2pr7XQPs6sP8G0j6U+3LtggD2V10rnS0B6OSNviIJBtKWX+YA7Dy?=
 =?us-ascii?Q?FzAMzw20A8pYB3XQQ4ySnN7hD9wxPFxuOhx+nlKTHlwDW3S87qkap8E+92Ts?=
 =?us-ascii?Q?oQMKbpgpbWf/2bQmnOJJ/M/8Rw3v+LDjxOC0lKlzPr19VQBGwnoDlGA3Nyb7?=
 =?us-ascii?Q?gtD2rfzqiMothCofu9JZ3CPZAPxJrIBmOHx4pfKh4tVjTHuDKizDpKhwYyP2?=
 =?us-ascii?Q?WaGc5HUPX0GnXU0AtN64XAQKsgpX33xG/C/7dh2oXeUo9xr17+mkWQ1P3pEL?=
 =?us-ascii?Q?pG1KfaxVYSGtHo25moTFKrzGMWl7f9KsLHMFgFEO60+ON5P2qZIWhAzZ/qJs?=
 =?us-ascii?Q?gexGNH4hurtyq0GUSroQHlr4X8aEeE0MYlOv0EYSSjbtepsvEDR10bTdmlmS?=
 =?us-ascii?Q?NmL9Y0WaIg5VIuJU5BrHeGdqbY0nD/smCmZFfmC69ygTdpSWOQ3M02LDYqN9?=
 =?us-ascii?Q?Ou5lnDkZQBAVKvGJAZdK8GOF0oJrbzgRx6mkg7XGZlwqFTiNcKw77LWB9COs?=
 =?us-ascii?Q?yFtU6a7vOX8W0VxQftu3E5LNN1lc0WfCf/jWXUxPFBrJIttiqm+96hsg5gzP?=
 =?us-ascii?Q?07IVyjOJO82N8Ls3YhnuoMMGk31kJtzJnj7+Ctxz3UDgoVF3qTob+Jiq69kZ?=
 =?us-ascii?Q?tl29D0nCsybx2rkc9eOg2SnDxrhsN76d/wKTw13eYLXfnvkeNBmufQz6oNH1?=
 =?us-ascii?Q?phlgHlrsG3dmbS9dbzewqLmWuUMjNpiHBdUYU9xR3/x22NubNHlRx/HnEbV1?=
 =?us-ascii?Q?A2TKCO6+stFFTWj2LXHlYXf6tXGHpbDiiRaH6pOyMz/aStrHqpqOJ+npZdov?=
 =?us-ascii?Q?FiWDGdiOA6VMaeWVQ7zwBUtV03ngM9NH/Lfs8CuHunvYoK3tjNyBt+GGKfXK?=
 =?us-ascii?Q?0/OiQMWqzfEm1M0tTj988M2fZkA1w1DTaa/Pr27ruUxSzS3gRwmcnpUzX8yC?=
 =?us-ascii?Q?8bih/gtkEV6LCMZOEx3iWO1tA3dhqENcehcf7Ol3sjRui6Ro1sfiMTtMXOvg?=
 =?us-ascii?Q?UBY+GGmY082rYxN5egKWwces5xBHdMKzN7l+1v1UDN5FZtELBgolOjKB58rH?=
 =?us-ascii?Q?6pxQHSqWDXzUrWzCM3xvSVCIu/jfDUTXcwbXB2A4ig23yvUyMHZkx9oRGyKP?=
 =?us-ascii?Q?dTjuIGkHU7jJPP8LZPJ75y57bdwM/UZ/UdX8hBWUPOiR0yzqLWhtAE+9N4Dz?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62388fd9-ce14-47f4-baa2-08dcdb888dd7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 04:31:12.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibJmwAzvINVlOcQQUXJhT9xTP5xNwCSTOwQ+RwlXK84SKuNJ584DW/w4q+K23IfvbIQARlyQBOoEIVg2DK2VQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com

--wdyGV4FNiAvJ62eC
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi, Kan,

On Fri, Sep 20, 2024 at 09:27:06AM -0400, Liang, Kan wrote:

> > ...
> > =1B[32mPASS=1B[0m msr (1836 tests)
> > =1B[31mFAIL=1B[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  =
<---
>=20
> Is there a list to show which checks are failed?

I attached a pmu.log.

below failed which can pass on parent (v6.11-rc5)

FAIL: Intel: overflow: cntr-0
FAIL: Intel: overflow: status-0
FAIL: Intel: overflow: cntr-1
FAIL: Intel: overflow: status-1
FAIL: Intel: overflow: irq-1
FAIL: Intel: overflow: cntr-2
FAIL: Intel: overflow: status-2
FAIL: Intel: overflow: cntr-3
FAIL: Intel: overflow: status-3
FAIL: Intel: overflow: irq-3
FAIL: Intel: overflow: cntr-4
FAIL: Intel: overflow: status-4
FAIL: Intel: full-width writes: overflow: cntr-0
FAIL: Intel: full-width writes: overflow: status-0
FAIL: Intel: full-width writes: overflow: cntr-1
FAIL: Intel: full-width writes: overflow: status-1
FAIL: Intel: full-width writes: overflow: irq-1
FAIL: Intel: full-width writes: overflow: cntr-2
FAIL: Intel: full-width writes: overflow: status-2
FAIL: Intel: full-width writes: overflow: cntr-3
FAIL: Intel: full-width writes: overflow: status-3
FAIL: Intel: full-width writes: overflow: irq-3
FAIL: Intel: full-width writes: overflow: cntr-4
FAIL: Intel: full-width writes: overflow: status-4


>=20
> Thanks,
> Kan
>=20
> > =1B[32mPASS=1B[0m pmu_lbr (3 tests)
> > =1B[33mSKIP=1B[0m pmu_pebs (1 tests, 1 skipped)
> > ...
> >=20
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-=
oliver.sang@intel.com
> >=20
> >=20
> >=20

--wdyGV4FNiAvJ62eC
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="pmu.log"

timeout -k 1s --foreground 90s /lkp/benchmarks/qemu/build/qemu-system-x86_64 --no-reboot -nodefaults -device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4 -vnc none -serial stdio -device pci-testdev -machine accel=kvm -kernel x86/pmu.flat -smp 1 -cpu max # -initrd /tmp/tmp.WgbBni4GGX
enabling apic
smp: waiting for 0 APs
paging enabled
cr0 = 80010011
cr3 = 1007000
cr4 = 20
PASS: Expected #GP on RDPMC(64)
PMU version:         2
GP counters:         4
GP counter width:    48
Mask length:         7
Fixed counters:      3
Fixed counter width: 48
PASS: Intel: core cycles-0
PASS: Intel: core cycles-1
PASS: Intel: core cycles-2
PASS: Intel: core cycles-3
PASS: Intel: instructions-0
PASS: Intel: instructions-1
PASS: Intel: instructions-2
PASS: Intel: instructions-3
PASS: Intel: ref cycles-0
PASS: Intel: ref cycles-1
PASS: Intel: ref cycles-2
PASS: Intel: ref cycles-3
PASS: Intel: llc references-0
PASS: Intel: llc references-1
PASS: Intel: llc references-2
PASS: Intel: llc references-3
PASS: Intel: llc misses-0
PASS: Intel: llc misses-1
PASS: Intel: llc misses-2
PASS: Intel: llc misses-3
PASS: Intel: branches-0
PASS: Intel: branches-1
PASS: Intel: branches-2
PASS: Intel: branches-3
PASS: Intel: branch misses-0
PASS: Intel: branch misses-1
PASS: Intel: branch misses-2
PASS: Intel: branch misses-3
PASS: Intel: fixed-0
PASS: Intel: fixed-1
PASS: Intel: fixed-2
PASS: Intel: rdpmc: cntr-0
SKIP: Intel: rdpmc: fast-0
PASS: Intel: rdpmc: cntr-1
SKIP: Intel: rdpmc: fast-1
PASS: Intel: rdpmc: cntr-2
SKIP: Intel: rdpmc: fast-2
PASS: Intel: rdpmc: cntr-3
SKIP: Intel: rdpmc: fast-3
PASS: Intel: rdpmc: fixed cntr-0
SKIP: Intel: rdpmc: fixed fast-0
PASS: Intel: rdpmc: fixed cntr-1
SKIP: Intel: rdpmc: fixed fast-1
PASS: Intel: rdpmc: fixed cntr-2
SKIP: Intel: rdpmc: fixed fast-2
PASS: Intel: all counters
FAIL: Intel: overflow: cntr-0
FAIL: Intel: overflow: status-0
PASS: Intel: overflow: status clear-0
PASS: Intel: overflow: irq-0
FAIL: Intel: overflow: cntr-1
FAIL: Intel: overflow: status-1
PASS: Intel: overflow: status clear-1
FAIL: Intel: overflow: irq-1
FAIL: Intel: overflow: cntr-2
FAIL: Intel: overflow: status-2
PASS: Intel: overflow: status clear-2
PASS: Intel: overflow: irq-2
FAIL: Intel: overflow: cntr-3
FAIL: Intel: overflow: status-3
PASS: Intel: overflow: status clear-3
FAIL: Intel: overflow: irq-3
FAIL: Intel: overflow: cntr-4
FAIL: Intel: overflow: status-4
PASS: Intel: overflow: status clear-4
PASS: Intel: overflow: irq-4
PASS: Intel: cmask
PASS: Intel: running counter wrmsr: cntr
PASS: Intel: running counter wrmsr: status msr bit
PASS: Intel: full-width writes: core cycles-0
PASS: Intel: full-width writes: core cycles-1
PASS: Intel: full-width writes: core cycles-2
PASS: Intel: full-width writes: core cycles-3
PASS: Intel: full-width writes: instructions-0
PASS: Intel: full-width writes: instructions-1
PASS: Intel: full-width writes: instructions-2
PASS: Intel: full-width writes: instructions-3
PASS: Intel: full-width writes: ref cycles-0
PASS: Intel: full-width writes: ref cycles-1
PASS: Intel: full-width writes: ref cycles-2
PASS: Intel: full-width writes: ref cycles-3
PASS: Intel: full-width writes: llc references-0
PASS: Intel: full-width writes: llc references-1
PASS: Intel: full-width writes: llc references-2
PASS: Intel: full-width writes: llc references-3
PASS: Intel: full-width writes: llc misses-0
PASS: Intel: full-width writes: llc misses-1
PASS: Intel: full-width writes: llc misses-2
PASS: Intel: full-width writes: llc misses-3
PASS: Intel: full-width writes: branches-0
PASS: Intel: full-width writes: branches-1
PASS: Intel: full-width writes: branches-2
PASS: Intel: full-width writes: branches-3
PASS: Intel: full-width writes: branch misses-0
PASS: Intel: full-width writes: branch misses-1
PASS: Intel: full-width writes: branch misses-2
PASS: Intel: full-width writes: branch misses-3
PASS: Intel: full-width writes: fixed-0
PASS: Intel: full-width writes: fixed-1
PASS: Intel: full-width writes: fixed-2
PASS: Intel: full-width writes: rdpmc: cntr-0
SKIP: Intel: full-width writes: rdpmc: fast-0
PASS: Intel: full-width writes: rdpmc: cntr-1
SKIP: Intel: full-width writes: rdpmc: fast-1
PASS: Intel: full-width writes: rdpmc: cntr-2
SKIP: Intel: full-width writes: rdpmc: fast-2
PASS: Intel: full-width writes: rdpmc: cntr-3
SKIP: Intel: full-width writes: rdpmc: fast-3
PASS: Intel: full-width writes: rdpmc: fixed cntr-0
SKIP: Intel: full-width writes: rdpmc: fixed fast-0
PASS: Intel: full-width writes: rdpmc: fixed cntr-1
SKIP: Intel: full-width writes: rdpmc: fixed fast-1
PASS: Intel: full-width writes: rdpmc: fixed cntr-2
SKIP: Intel: full-width writes: rdpmc: fixed fast-2
PASS: Intel: full-width writes: all counters
FAIL: Intel: full-width writes: overflow: cntr-0
FAIL: Intel: full-width writes: overflow: status-0
PASS: Intel: full-width writes: overflow: status clear-0
PASS: Intel: full-width writes: overflow: irq-0
FAIL: Intel: full-width writes: overflow: cntr-1
FAIL: Intel: full-width writes: overflow: status-1
PASS: Intel: full-width writes: overflow: status clear-1
FAIL: Intel: full-width writes: overflow: irq-1
FAIL: Intel: full-width writes: overflow: cntr-2
FAIL: Intel: full-width writes: overflow: status-2
PASS: Intel: full-width writes: overflow: status clear-2
PASS: Intel: full-width writes: overflow: irq-2
FAIL: Intel: full-width writes: overflow: cntr-3
FAIL: Intel: full-width writes: overflow: status-3
PASS: Intel: full-width writes: overflow: status clear-3
FAIL: Intel: full-width writes: overflow: irq-3
FAIL: Intel: full-width writes: overflow: cntr-4
FAIL: Intel: full-width writes: overflow: status-4
PASS: Intel: full-width writes: overflow: status clear-4
PASS: Intel: full-width writes: overflow: irq-4
PASS: Intel: full-width writes: cmask
PASS: Intel: full-width writes: running counter wrmsr: cntr
PASS: Intel: full-width writes: running counter wrmsr: status msr bit
PASS: Intel: full-width writes: writing unsupported width to MSR_IA32_PMC0 raises #GP
PASS: Intel: full-width writes: writing unsupported width to MSR_IA32_PMC1 raises #GP
PASS: Intel: full-width writes: writing unsupported width to MSR_IA32_PMC2 raises #GP
PASS: Intel: full-width writes: writing unsupported width to MSR_IA32_PMC3 raises #GP
SUMMARY: 143 tests, 24 unexpected failures, 14 skipped


--wdyGV4FNiAvJ62eC--
