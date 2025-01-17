Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACD1B0409
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139457; cv=fail; b=T238vV7CqDDd1Pnwo3Ixovvoy9rwxku1ptwUofV3PYTjI+XhnPbhnOO7iv3v2G0OoYTSEcnD11rm3q4hHqcQcaQo5CI/cxMrhOPHPFyohPOq59k5DqDNgxJtTPI1P7Tym9QnWHRn1CYhJeQcXo9gwtaCHCOkgoqVoh7+yVHOJgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139457; c=relaxed/simple;
	bh=DkaHSCQs0kOoge8/Lzt4T2x9vRm6fksdOYKVMreVfSQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c2B/zCSuLe+nCXT6gu+hr9ca/t55psWbWllcm/SKVd9UNAfZmHylJfBfg53cSnEkaex9qcmPtEPd87xlZ7Fd23LwNJ56F/LtZRIe0zEyIEAygDanOC05j1Vfzakb9kIMuaUfFAccTYsAzv/t/anawkH0jvfdbeS2L5dwnzPD+h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4HXeJ+9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4HXeJ+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737139451; x=1768675451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DkaHSCQs0kOoge8/Lzt4T2x9vRm6fksdOYKVMreVfSQ=;
  b=A4HXeJ+9Xc5Bwoy0/IXEUMnCYEQhndCGZBx+jCDXtIHN7VzDyQ9jGR/X
   qPag1je9f7EF5dSRgm9SNwa6hUxVW2LUORqOnbnlRC/HO1AefzRx+FmOy
   0+PmZQs8io7Y+oqs7Qvx5FwS9rDG5s9q6pYjEBrHjvRh/bnrbLmR7d7Ji
   6xk9NwufGL0kNQVuNiom3Qb57wJSkkX0teMdM8x8rUL5l7oREqC3BEkzb
   zAbENnfOldGkJ4WjSbN7z7pN6sjFbdk0ZaWHVJVXgOgt9rgEzWRRgGnic
   RORLZxnMt5u/uOWkoLPoT+Mn/58UzWk6X7gpykMCWKttEXB/N3MKFTbsr
   A==;
X-CSE-ConnectionGUID: yBOnj37TS7KbAcm+jSDL1Q==
X-CSE-MsgGUID: N4tWJZnSQtOSGRikJRYrwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="55131025"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="55131025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:44:08 -0800
X-CSE-ConnectionGUID: zDMipCeJTfajktLgAzRVZQ==
X-CSE-MsgGUID: EMz/dVdDSTuRJGvHzc+0Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="136713415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:44:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:44:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:44:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:44:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stSOqKsLXov1e/iCLJ0houoYxjhqTKvBQKX/6WavMX3INA/OWpZZ9WasyBEtpjEqAtzHlIXRLfgo8i7JAD9AhzRVmSOy6vkpexucO2l8Rue6cjw6bwcUWRMSFIsfiE0x0E60C63WP+9Vv2Ebr7nfROjFnv7Rgs78eqwC7M4sg1CYmMllo2eb9i8KcHzamD5bLW79J8pIjmF/w9yHa9RWHCdMd3afrY3JOTaSLVYMJqxByrAgihfsJelIR+X82hMtdoP4PeKpiqLS/y+pFx7pFHgC85axnuuVYspijbHdS9f/Aut14EzactOylbZwV5GjxDoFInTR//K6GDxFYrkCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P09dJz49lqGKdksqGVEeoScK/F0sDerf7Ixt1azdr70=;
 b=Tz4POZbzYzd61bfT+86dkbczKUhYRruHoU5vOSF2JkvM/355cckKyPHH5KW89oIkkKtPv0gwHH20AmHFcCG05nfzwvbeU3MhkgMHk18gK8iUgLHFLfAz4OtyOVID4vUSZaIKfGKtXUtLz7bQQScdT+THekU7qLXI+OCJpJjXDblDfh9RLFtfvD1o1xY0r8v8brvyDB8ejp3zc3YuOPbKa8z3cmTTnfnpdfMQgnbYoDIbPstIV1tcmkDTHof1ZGqd5ZOCih3P3PkoyNNCDGcvCVrvzX3PsS7S5wsNSC8V7+2p5QB7AEe3EIF+rfyJkJuJKNCWRXypGYq/HxnsQN89Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 18:44:05 +0000
Received: from SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72]) by SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 18:44:05 +0000
Date: Fri, 17 Jan 2025 13:44:02 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <Z4qk8qv1_VyV8W80@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116230718.82460-8-lucas.demarchi@intel.com>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To SN7PR11MB8282.namprd11.prod.outlook.com
 (2603:10b6:806:269::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8282:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: be613658-8f38-4a7c-4ee0-08dd3726eb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bzZAbmmkMW/QVXCgujM+Otk77+apn9Naaxg9F7nXL3e0+X4/X5bQCcM+EjCf?=
 =?us-ascii?Q?MNYsFyWjMXP6eW0qYFqzv1p6bvIArQc7+PGuehirvkOg6uDYb9Jil7LhbtkR?=
 =?us-ascii?Q?WPjkysNLaKEOoGiI+INMmzJR8Jmt0vkQfdvKQjfXKB1nScscA348f4b7YYeg?=
 =?us-ascii?Q?LmIK2CRYxLOgjJ8wsE3HnpxgQWOqdBUZKGMLOO4R0KrD1PyoKia0xR5nSoLS?=
 =?us-ascii?Q?7m3OB5c+pUXv99LswoHb/JQVDcQvBIBWYawDfohvxhM3Zy27+9KDrK7DCTAP?=
 =?us-ascii?Q?maXxLBR+z07NTfi71DwpC/EzYeBmZufKj3li4F3hxPMBAg+DHEmkIZT0QaHW?=
 =?us-ascii?Q?oJjr06skl6V77kMo5nUqRz+0w29wJrfS4CQMkzYlctUJ9VdwJy6LWUYzgjBQ?=
 =?us-ascii?Q?6ZxxYKXVfBLcjLrvejXHrO+bTZfV/Tw1TbNBg992WdkeRKLMb6DNcmaShDGD?=
 =?us-ascii?Q?9LZvldBYcXt8pz+/qicLS+vQOALk9gxZcIVtpBMu1UFdzfMx4LpgdlKUkZNu?=
 =?us-ascii?Q?OtQXm8GfXtKUlkHRZ2YrHkbLoREBjER8po5o0ueBFIa8d+Aek+ts87kUQ2bY?=
 =?us-ascii?Q?HjqEqX2gkERLcsk6GekcO2HIJxG+4897Kp63yCXXP1rzPBb9BA9pL29bI5hf?=
 =?us-ascii?Q?jIMFQit0H15wC6sjmfg6p/9uKi/7fk8f+7e9mvN+WVYEYD2P7Pq9xYsOWNJl?=
 =?us-ascii?Q?RnRPJ8QMSMBjLlwayJCZIY7Wq3hjfQRP+bvKXGvBiHeaheCnp6n/b4GuRA8y?=
 =?us-ascii?Q?AS3BmaCG772zutSQ7Y5p/pjQXUVhG6hE6OJWsQQLt9HaPfH2TNtmVbVTOBNM?=
 =?us-ascii?Q?KpKPha1fRN0A4kqcr2ZqxC8vzI/vL1s+uFJyy2IXK5m2yX+I3mFQS19xvKwj?=
 =?us-ascii?Q?56hNxyXhcbKQnse+GSjIfYI0OteoJcsn08byrCjKkBmVeCwGkxc5f+SfvZ3a?=
 =?us-ascii?Q?MXkpQDbDD+JuysV6CrjL4YAy6RILsGneGeAgw3HdGlShj4vMipqao0AeH+7M?=
 =?us-ascii?Q?/Nhrq0E81uRgEYrmkTAc0lXOtCYYRY0/Ra7M/iAGodO4shyAv2o6+lekXcS+?=
 =?us-ascii?Q?Ww+vHyjZxiRH6o2Czq14BPVJwc9lmlMCAU7rx+mBKKqkOQhCyw8OCW88s6ug?=
 =?us-ascii?Q?4mVbCodVt8D5/su3bZRnYaSxenyCPlMwdU87n072kXOLWkNJR3NFol5Za6bk?=
 =?us-ascii?Q?mSrbCfXoAEGgxAzylTVteWCXxthVuom0O/PDRNko0tP15JQpo0l+nkvXgIIq?=
 =?us-ascii?Q?SWiTy1ZQdEfGO0+0XnI49mCVNJ7/Zx2bwgLXZMZa219avvk7Qn2fiqaUuI0e?=
 =?us-ascii?Q?viUniJHV9/XdxNZhglO+m3w52pAPWX/Jdoog5aaqF4Pwmd6Kl00czWxYa8vn?=
 =?us-ascii?Q?Ov6vO4AqkFljC1pdg8KH9aU00dhD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFwNf8QCPVJ2+mg8wnU71bqD9YVgj2q+82xGkfEFGLXDlViFQXKN5ZrcKKly?=
 =?us-ascii?Q?RVwaxmilTIufISH0lyjJfXGLWZ1MiV3qw78zdesbUr+UTewwCMausiFQ854A?=
 =?us-ascii?Q?TRMunPuM5bkaM0EqN++7xbXT17Tf/8UyfEeKYAWZTpafwew9KT/3hfSzjaWq?=
 =?us-ascii?Q?nkDpYsF+Z6Di/hRMy72TBRTRhsmpsJ0G6Kkz2S4of3n2UPknDiSwhqUf/KIz?=
 =?us-ascii?Q?rVAJ6FMTst0IGNEAOHeQITnFMq/tKTSL97/EDtFrvNfpNF93K2Icy+c5KREA?=
 =?us-ascii?Q?hT9DN8ZVeNycfWtQA6eNbiB1GKIpg5/ovBRSTxpoYdFMPNTy5rOlz8pmVayz?=
 =?us-ascii?Q?j42ttFJd5z+tYVE342usVxjmR61n5iBOZd2ca61Sp9Ac+tiLut0IvTZ952bX?=
 =?us-ascii?Q?pIJQbZaPsE9HBfRmEgv6RPtfOCjylVyIf6/s7z8YN9A/GrkW0A5sNDNpJhdt?=
 =?us-ascii?Q?rg4+fGOpS73jhmF+dDzpGkS6vZg0wkxyUTeuittGlN61c6d7ue/5fwBM9bGw?=
 =?us-ascii?Q?FoGB2lf8tMeCAHSdPFlDREf69cxRzpCD2Q1ajTOPgFsHPzEPVtYOMLWVUuWh?=
 =?us-ascii?Q?NWtoslFkqW5DQLJatj/mgqQbXmtRlzWHro/er8MMYJBY04xnh0ta39n/GPIj?=
 =?us-ascii?Q?FgwafLBFELabSM2uLuPNXpgLpMpYsqIF9Ayr5EtG7/EmMhcODkNoMZN8EIt8?=
 =?us-ascii?Q?Gvf3xpmjyHKGbGeBo+6eWTdKQE+rd24Gt+hHxG5vOp8VaPbPWxihEIQc+zLv?=
 =?us-ascii?Q?SWP7MFwfbighzTZ8OAHYXZrpSXP0xdLHSpMd0GfiIvg0a4a1oyFx2mSIq17I?=
 =?us-ascii?Q?M0s54y52jH1T/siLDgPQ/1hdv/eUwKdbJTAA8tp3WdYmg8dnKSl8E7Ul7WNN?=
 =?us-ascii?Q?WM/T3qq9QCu9xlzOTOH+0oQb+hBoJrCFUPWcuWqN4/KUC+vjtOvMPxFt5QPp?=
 =?us-ascii?Q?z2PblFdpJzdRsiMhffRA90Dm0KofaBLkdgbqULY+ym2uyXjUVGFGeS7OlXR8?=
 =?us-ascii?Q?nzuAe21sKCD4LkwjKi9C28xsX5ob4Mpwnwe5QF7/+YKWpvGEfa9qTxMvuS0Q?=
 =?us-ascii?Q?BJmbQwDcGJd1HBHSI+BkBAivY4+J7d46EOKhZDZaGpIkybNxBD6+joBYbOTI?=
 =?us-ascii?Q?Yzk868w1qBAqIDaUEAxdaXkOONUMGbj2fimy13LWyhNI8Z/ieWeXBKIhKha5?=
 =?us-ascii?Q?k/DD3lHpf4ltwuIq0H4KNUzynfCoNhkDtUBR6HFigg415zENx7X/t1ReYtwl?=
 =?us-ascii?Q?cSWFMrpiUW/wMPUqwlwsQ5v9FcjOXyHy912TxnurxyukuOK488ESkuBBEicb?=
 =?us-ascii?Q?0lnMP8p28msWBV703/QNPPqEf9sz4avE4VnLqOESOhBVqrxJqJkKQqJFHpA8?=
 =?us-ascii?Q?XhniSZnrVHp5lfJyaRcEwUDxN/5yS4qoQDdywfepfzUasPICGnSZGIB88/Sj?=
 =?us-ascii?Q?5m9X2q/sSQyaVCeLOI6Qbse5/Z0azbMxZCOCJVnL91QEz0OEmssjUY7AqURT?=
 =?us-ascii?Q?SdweQWUfxOqlHg0Anq42bFe5Futgh9QizndzCWkYmVjE05bUMVIzi2QG/e3x?=
 =?us-ascii?Q?UGXMW2iYhl7pKs0cE5We1+VqYVPQBjMdetSci4JiqpSujhG5E4T2eLOOE/PM?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be613658-8f38-4a7c-4ee0-08dd3726eb26
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:44:05.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKb92J6jKLwcO8exCcf8tDU6xmicH5z97MzIJPxFIzmijUe9YR3Nyq83vRMpiUD2ZQZFhKK7Zlg26JCceoAh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 03:07:18PM -0800, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Provide a PMU interface for GT C6 residency counters. The implementation
> is ported over from the i915 PMU code. Residency is provided in units of
> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
> 
> Sample usage and output:
> 
> 	$ perf list | grep gt-c6
> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
> 
> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
> 	event=0x01
> 
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
> 	ms
> 
> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
> 	#           time             counts unit events
> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> 
> Besides the rebase, that changed a lot how the event was added,
> here is a summary of other changes:
> 
> - Use xe_pm_runtime_get_if_active() when reading
>   xe_gt_idle_residency_msec() as there's not guarantee it will not be
>   suspended anymore by the time it reads the counter
> 
> - Drop sample[] from the pmu struct and only use the prev/counter from
>   the perf_event struct. This avoids mixing the counter reported to 2
>   separate clients.
> 
> - Drop time ktime helpers and just use what's provided by
>   include/linux/ktime.h
> 
>  drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index c2af82ec3f793..37df9d3cc110c 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -11,6 +11,7 @@
>  #include "xe_device.h"
>  #include "xe_force_wake.h"
>  #include "xe_gt_clock.h"
> +#include "xe_gt_idle.h"
>  #include "xe_gt_printk.h"
>  #include "xe_mmio.h"
>  #include "xe_macros.h"
> @@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event *event)
>  	return 0;
>  }
>  
> -static u64 __xe_pmu_event_read(struct perf_event *event)
> +static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt *gt, u64 prev)
>  {
> -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_device *xe = gt_to_xe(gt);
> +	unsigned long flags;
> +	ktime_t t0;
> +	s64 delta;
> +
> +	if (xe_pm_runtime_get_if_active(xe)) {
> +		u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
> +
> +		xe_pm_runtime_put(xe);
> +
> +		return val;
> +	}
> +
> +	/*
> +	 * Estimate the idle residency by looking at the time the device was
> +	 * suspended: should be good enough as long as the sampling frequency is
> +	 * 2x or more than the suspend frequency.
> +	 */
> +	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	t0 = pmu->suspend_timestamp[gt->info.id];
> +	raw_spin_unlock_irqrestore(&pmu->lock, flags);

I believe we should simply avoid the patch 4 and this block and use
xe_pm_runtime_get(xe) instead of the if_active variant.

I'm afraid this won't be a good estimative since this mix 2 different wakes
of 2 different IP blocks... the runtime pm is for the entire device, while
in runtime active the GTs can be sleeping in GT-C6.

or did we get some deadlock risk on that scenario?
perhaps we should get runtime pm in upper layers when using PMU?

> +
> +	delta = ktime_ms_delta(ktime_get(), t0);
> +
> +	return prev + delta;
> +}
> +
> +static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
> +{
> +	struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>  	struct xe_gt *gt = event_to_gt(event);
> -	u64 val = 0;
>  
>  	if (!gt)
> -		return 0;
> +		return prev;
> +
> +	switch (config_to_event_id(event->attr.config)) {
> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
> +		return read_gt_c6_residency(pmu, gt, prev);
> +	}
>  
> -	return val;
> +	return prev;
>  }
>  
>  static void xe_pmu_event_update(struct perf_event *event)
> @@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct perf_event *event)
>  
>  	prev = local64_read(&hwc->prev_count);
>  	do {
> -		new = __xe_pmu_event_read(event);
> +		new = __xe_pmu_event_read(event, prev);
>  	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>  
> -	local64_add(new - prev, &event->count);
> +	if (new > prev)
> +		local64_add(new - prev, &event->count);
>  }
>  
>  static void xe_pmu_event_read(struct perf_event *event)
> @@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
>  	 * for all listeners. Even when the event was already enabled and has
>  	 * an existing non-zero value.
>  	 */
> -	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
> +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
>  }
>  
>  static void xe_pmu_event_start(struct perf_event *event, int flags)
> @@ -267,6 +303,10 @@ static const struct attribute_group pmu_events_attr_group = {
>  
>  static void set_supported_events(struct xe_pmu *pmu)
>  {
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!xe->info.skip_guc_pc)
> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>  }
>  
>  /**
> -- 
> 2.48.0
> 
