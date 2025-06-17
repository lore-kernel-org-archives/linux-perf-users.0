Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B72EAB64;
	Tue, 17 Jun 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186583; cv=none; b=PqhyITMTTy4zVPhrmZl6F44i9W+LE8whS1fNRptcPgf+zkQ7UAJWnfNd1INcUb8gJxpnwNw4rrPM5Sx37uD08xcx8rUS/tJXLdv6itrwolwz4ERtZcWj8YqvpuK3XFht240FZrLBlhW4vORKHK317cRTYcKQI3ag5F0uzYLor0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186583; c=relaxed/simple;
	bh=BmAfJrzVultOfC2eUw0e9/7gnZO+N5yHLkG90+6Itkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9DSNDbp2AYsPf4spfo+Ic5qLsd8J73RTARChAqw+Ejk1JKDjgsguocdLNHHXgNZF8ymfg1G7HCSBnEEIhdFJXmXcszl6G69MYbEQlA1V3Ww1wbvwsvQRpcj5C/RaEzqcA1jNik9NR3zHgdcGBw1Jm5Ke/BtOsa2yr2hcKdq6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFvhQ6bq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFvhQ6bq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750186580; x=1781722580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BmAfJrzVultOfC2eUw0e9/7gnZO+N5yHLkG90+6Itkg=;
  b=fFvhQ6bqkOcKm18MYUAnG46NOg335OHTbbCP6lSfqvhNxEiAKIbGrjFR
   y3bftQuhKWWVtuSXQUtCxGrapzFY8OxKQYD3vJln+1zoOcbrxat9rS80C
   eEZgd13/u4NSa8coiRSfC5xuYnhtWy2enb8AONs2E6MKmIeRqr5VVTzqG
   /lIV+eYgfMxKKiA1wJv2m71h8G3M4CA2rhORbRLDwAWat9BwxG0h7F28n
   aK1FyRnGKTdyNfNI/3Sd80QoIWulFq4qsViRkaZy4PAmTM/TZPgj3QpIR
   jy3vkYPzYFsO43NLXNBiicmUhb4qvsXAF/p8yPv1w8t0sicGHGxU+t0TP
   A==;
X-CSE-ConnectionGUID: GGRbxjCpTjmIWHmEypfuDw==
X-CSE-MsgGUID: sWBB1URbS6uvGNwMf7DLDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52520214"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52520214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:56:19 -0700
X-CSE-ConnectionGUID: 9wykvPMnQc+1mbuVaNJ/+A==
X-CSE-MsgGUID: TlUODuEcTPmE2AxibPFaLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149791868"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 11:56:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRbTh-000I0E-1v;
	Tue, 17 Jun 2025 18:56:13 +0000
Date: Wed, 18 Jun 2025 02:55:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
Message-ID: <202506180203.PSKW4lGq-lkp@intel.com>
References: <20250617005800.1410112-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617005800.1410112-2-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc2 next-20250617]
[cannot apply to tip/timers/vdso acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250617-085916
base:   linus/master
patch link:    https://lore.kernel.org/r/20250617005800.1410112-2-irogers%40google.com
patch subject: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
config: i386-randconfig-062-20250617 (https://download.01.org/0day-ci/archive/20250618/202506180203.PSKW4lGq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506180203.PSKW4lGq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506180203.PSKW4lGq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/megaraid/megaraid_sas_base.c:4656:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4656:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4656:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4907:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4907:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4907:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6748:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6748:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6748:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4563:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4563:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4563:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:204:26: sparse: sparse: symbol 'megasas_mgmt_info' was not declared. Should it be static?
   drivers/scsi/megaraid/megaraid_sas_base.c:293:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:299:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:425:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1235:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] opcode @@     got restricted __le32 [usertype] opcode @@
   drivers/scsi/megaraid/megaraid_sas_base.c:1235:32: sparse:     expected unsigned int [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1235:32: sparse:     got restricted __le32 [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:2019:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2060:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c: note: in included file:
   drivers/scsi/megaraid/megaraid_sas.h:2485:32: sparse: sparse: array of flexible structures
   drivers/scsi/megaraid/megaraid_sas_base.c:4787:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4787:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4787:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5027:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5027:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5027:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5212:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5212:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5212:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5294:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5294:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5294:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6301:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6300:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6300:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6300:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6305:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6304:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6304:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6304:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6612:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6612:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6612:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6826:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6826:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6826:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:7583:44: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:8200:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected int crash_support @@     got restricted __le32 @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8200:23: sparse:     expected int crash_support
   drivers/scsi/megaraid/megaraid_sas_base.c:8200:23: sparse:     got restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:8284:31: sparse: sparse: invalid assignment: &=
   drivers/scsi/megaraid/megaraid_sas_base.c:8284:31: sparse:    left side has type restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:8284:31: sparse:    right side has type int
>> drivers/scsi/megaraid/megaraid_sas_base.c:8438:32: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/megaraid/megaraid_sas_base.c:8809:46: sparse: sparse: restricted __le32 degrades to integer

vim +8438 drivers/scsi/megaraid/megaraid_sas_base.c

fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8225  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8226  /**
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8227   * megasas_mgmt_fw_ioctl -	Issues management ioctls to FW
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8228   * @instance:			Adapter soft state
2b46e5c14218c7 drivers/scsi/megaraid/megaraid_sas_base.c Damien Le Moal             2020-07-06  8229   * @user_ioc:			User's ioctl packet
2b46e5c14218c7 drivers/scsi/megaraid/megaraid_sas_base.c Damien Le Moal             2020-07-06  8230   * @ioc:			ioctl packet
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8231   */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8232  static int
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8233  megasas_mgmt_fw_ioctl(struct megasas_instance *instance,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8234  		      struct megasas_iocpacket __user * user_ioc,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8235  		      struct megasas_iocpacket *ioc)
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8236  {
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8237  	struct megasas_sge64 *kern_sge64 = NULL;
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8238  	struct megasas_sge32 *kern_sge32 = NULL;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8239  	struct megasas_cmd *cmd;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8240  	void *kbuff_arr[MAX_IOCTL_SGE];
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8241  	dma_addr_t buf_handle = 0;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8242  	int error = 0, i;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8243  	void *sense = NULL;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8244  	dma_addr_t sense_handle;
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8245  	void *sense_ptr;
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8246  	u32 opcode = 0;
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8247  	int ret = DCMD_SUCCESS;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8248  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8249  	memset(kbuff_arr, 0, sizeof(kbuff_arr));
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8250  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8251  	if (ioc->sge_count > MAX_IOCTL_SGE) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  8252  		dev_printk(KERN_DEBUG, &instance->pdev->dev, "SGE count [%d] >  max limit [%d]\n",
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8253  		       ioc->sge_count, MAX_IOCTL_SGE);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8254  		return -EINVAL;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8255  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8256  
f870bcbe9a9912 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-01-05  8257  	if ((ioc->frame.hdr.cmd >= MFI_CMD_OP_COUNT) ||
f870bcbe9a9912 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-01-05  8258  	    ((ioc->frame.hdr.cmd == MFI_CMD_NVME) &&
58136856167d10 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8259  	    !instance->support_nvme_passthru) ||
58136856167d10 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8260  	    ((ioc->frame.hdr.cmd == MFI_CMD_TOOLBOX) &&
58136856167d10 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8261  	    !instance->support_pci_lane_margining)) {
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8262  		dev_err(&instance->pdev->dev,
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8263  			"Received invalid ioctl command 0x%x\n",
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8264  			ioc->frame.hdr.cmd);
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8265  		return -ENOTSUPP;
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8266  	}
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8267  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8268  	cmd = megasas_get_cmd(instance);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8269  	if (!cmd) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  8270  		dev_printk(KERN_DEBUG, &instance->pdev->dev, "Failed to get a cmd packet\n");
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8271  		return -ENOMEM;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8272  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8273  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8274  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8275  	 * User's IOCTL packet has 2 frames (maximum). Copy those two
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8276  	 * frames into our cmd's frames. cmd->frame's context will get
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8277  	 * overwritten when we copy from user's frames. So set that value
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8278  	 * alone separately
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8279  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8280  	memcpy(cmd->frame, ioc->frame.raw, 2 * MEGAMFI_FRAME_SIZE);
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8281  	cmd->frame->hdr.context = cpu_to_le32(cmd->index);
c35188377f12e5 drivers/scsi/megaraid/megaraid_sas.c      Yang, Bo                   2009-10-06  8282  	cmd->frame->hdr.pad_0 = 0;
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8283  
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8284  	cmd->frame->hdr.flags &= (~MFI_FRAME_IEEE);
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8285  
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8286  	if (instance->consistent_mask_64bit)
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8287  		cmd->frame->hdr.flags |= cpu_to_le16((MFI_FRAME_SGL64 |
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8288  				       MFI_FRAME_SENSE64));
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8289  	else
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8290  		cmd->frame->hdr.flags &= cpu_to_le16(~(MFI_FRAME_SGL64 |
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8291  					       MFI_FRAME_SENSE64));
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8292  
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8293  	if (cmd->frame->hdr.cmd == MFI_CMD_DCMD)
8823abeddbbcef drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-08-23  8294  		opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8295  
8823abeddbbcef drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-08-23  8296  	if (opcode == MR_DCMD_CTRL_SHUTDOWN) {
7fa3174b3ef4e5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8297  		mutex_lock(&instance->reset_mutex);
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8298  		if (megasas_get_ctrl_info(instance) != DCMD_SUCCESS) {
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8299  			megasas_return_cmd(instance, cmd);
7fa3174b3ef4e5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8300  			mutex_unlock(&instance->reset_mutex);
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8301  			return -1;
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8302  		}
7fa3174b3ef4e5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  8303  		mutex_unlock(&instance->reset_mutex);
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8304  	}
95c060869e6872 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  8305  
8823abeddbbcef drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-08-23  8306  	if (opcode == MR_DRIVER_SET_APP_CRASHDUMP_MODE) {
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8307  		error = megasas_set_crash_dump_params_ioctl(cmd);
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8308  		megasas_return_cmd(instance, cmd);
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8309  		return error;
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8310  	}
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8311  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8312  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8313  	 * The management interface between applications and the fw uses
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8314  	 * MFI frames. E.g, RAID configuration changes, LD property changes
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8315  	 * etc are accomplishes through different kinds of MFI frames. The
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8316  	 * driver needs to care only about substituting user buffers with
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8317  	 * kernel buffers in SGLs. The location of SGL is embedded in the
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8318  	 * struct iocpacket itself.
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8319  	 */
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8320  	if (instance->consistent_mask_64bit)
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8321  		kern_sge64 = (struct megasas_sge64 *)
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8322  			((unsigned long)cmd->frame + ioc->sgl_off);
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8323  	else
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8324  		kern_sge32 = (struct megasas_sge32 *)
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8325  			((unsigned long)cmd->frame + ioc->sgl_off);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8326  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8327  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8328  	 * For each user buffer, create a mirror buffer and copy in
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8329  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8330  	for (i = 0; i < ioc->sge_count; i++) {
98cb7e4413d189 drivers/scsi/megaraid/megaraid_sas_base.c Bjørn Mork                 2011-01-19  8331  		if (!ioc->sgl[i].iov_len)
98cb7e4413d189 drivers/scsi/megaraid/megaraid_sas_base.c Bjørn Mork                 2011-01-19  8332  			continue;
98cb7e4413d189 drivers/scsi/megaraid/megaraid_sas_base.c Bjørn Mork                 2011-01-19  8333  
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8334  		kbuff_arr[i] = dma_alloc_coherent(&instance->pdev->dev,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8335  						    ioc->sgl[i].iov_len,
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8336  						    &buf_handle, GFP_KERNEL);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8337  		if (!kbuff_arr[i]) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  8338  			dev_printk(KERN_DEBUG, &instance->pdev->dev, "Failed to alloc "
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8339  			       "kernel SGL buffer for IOCTL\n");
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8340  			error = -ENOMEM;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8341  			goto out;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8342  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8343  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8344  		/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8345  		 * We don't change the dma_coherent_mask, so
60ee6529511601 drivers/scsi/megaraid/megaraid_sas_base.c Christoph Hellwig          2018-10-10  8346  		 * dma_alloc_coherent only returns 32bit addresses
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8347  		 */
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8348  		if (instance->consistent_mask_64bit) {
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8349  			kern_sge64[i].phys_addr = cpu_to_le64(buf_handle);
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8350  			kern_sge64[i].length = cpu_to_le32(ioc->sgl[i].iov_len);
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8351  		} else {
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8352  			kern_sge32[i].phys_addr = cpu_to_le32(buf_handle);
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8353  			kern_sge32[i].length = cpu_to_le32(ioc->sgl[i].iov_len);
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8354  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8355  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8356  		/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8357  		 * We created a kernel buffer corresponding to the
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8358  		 * user buffer. Now copy in from the user buffer
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8359  		 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8360  		if (copy_from_user(kbuff_arr[i], ioc->sgl[i].iov_base,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8361  				   (u32) (ioc->sgl[i].iov_len))) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8362  			error = -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8363  			goto out;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8364  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8365  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8366  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8367  	if (ioc->sense_len) {
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8368  		/* make sure the pointer is part of the frame */
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8369  		if (ioc->sense_off >
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8370  		    (sizeof(union megasas_frame) - sizeof(__le64))) {
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8371  			error = -EINVAL;
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8372  			goto out;
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8373  		}
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8374  
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8375  		sense = dma_alloc_coherent(&instance->pdev->dev, ioc->sense_len,
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8376  					     &sense_handle, GFP_KERNEL);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8377  		if (!sense) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8378  			error = -ENOMEM;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8379  			goto out;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8380  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8381  
b112036535eda3 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2021-01-05  8382  		/* always store 64 bits regardless of addressing */
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8383  		sense_ptr = (void *)cmd->frame + ioc->sense_off;
381d34e376e3d9 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8384  		put_unaligned_le64(sense_handle, sense_ptr);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8385  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8386  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8387  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8388  	 * Set the sync_cmd flag so that the ISR knows not to complete this
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8389  	 * cmd to the SCSI mid-layer
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8390  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8391  	cmd->sync_cmd = 1;
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8392  
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8393  	ret = megasas_issue_blocked_cmd(instance, cmd, 0);
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8394  	switch (ret) {
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8395  	case DCMD_INIT:
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8396  	case DCMD_BUSY:
6d40afbc7d1335 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8397  		cmd->sync_cmd = 0;
6d40afbc7d1335 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8398  		dev_err(&instance->pdev->dev,
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8399  			"return -EBUSY from %s %d cmd 0x%x opcode 0x%x cmd->cmd_status_drv 0x%x\n",
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8400  			 __func__, __LINE__, cmd->frame->hdr.cmd, opcode,
82add4e1b354f9 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8401  			 cmd->cmd_status_drv);
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8402  		error = -EBUSY;
201a810cc188af drivers/scsi/megaraid/megaraid_sas_base.c Anand Lodnoor              2020-01-14  8403  		goto out;
6d40afbc7d1335 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8404  	}
6d40afbc7d1335 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8405  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8406  	cmd->sync_cmd = 0;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8407  
aa00832b4ca649 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-11-17  8408  	if (instance->unload == 1) {
aa00832b4ca649 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-11-17  8409  		dev_info(&instance->pdev->dev, "Driver unload is in progress "
aa00832b4ca649 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-11-17  8410  			"don't submit data to application\n");
aa00832b4ca649 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-11-17  8411  		goto out;
aa00832b4ca649 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-11-17  8412  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8413  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8414  	 * copy out the kernel buffers to user buffers
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8415  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8416  	for (i = 0; i < ioc->sge_count; i++) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8417  		if (copy_to_user(ioc->sgl[i].iov_base, kbuff_arr[i],
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8418  				 ioc->sgl[i].iov_len)) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8419  			error = -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8420  			goto out;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8421  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8422  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8423  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8424  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8425  	 * copy out the sense
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8426  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8427  	if (ioc->sense_len) {
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8428  		void __user *uptr;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8429  		/*
b70a41e077b340 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2008-03-18  8430  		 * sense_ptr points to the location that has the user
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8431  		 * sense buffer address
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8432  		 */
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8433  		sense_ptr = (void *)ioc->frame.raw + ioc->sense_off;
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8434  		if (in_compat_syscall())
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8435  			uptr = compat_ptr(get_unaligned((compat_uptr_t *)
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8436  							sense_ptr));
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8437  		else
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30 @8438  			uptr = get_unaligned((void __user **)sense_ptr);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8439  
bba84aeccafb57 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2020-10-30  8440  		if (copy_to_user(uptr, sense, ioc->sense_len)) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  8441  			dev_err(&instance->pdev->dev, "Failed to copy out to user "
b10c36a57552f0 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  8442  					"sense data\n");
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8443  			error = -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8444  			goto out;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8445  		}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8446  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8447  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8448  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8449  	 * copy the status codes returned by the fw
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8450  	 */
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8451  	if (copy_to_user(&user_ioc->frame.hdr.cmd_status,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8452  			 &cmd->frame->hdr.cmd_status, sizeof(u8))) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  8453  		dev_printk(KERN_DEBUG, &instance->pdev->dev, "Error copying out cmd_status\n");
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8454  		error = -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8455  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8456  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8457  out:
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8458  	if (sense) {
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8459  		dma_free_coherent(&instance->pdev->dev, ioc->sense_len,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8460  				    sense, sense_handle);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8461  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8462  
7a6a731bd00ca9 drivers/scsi/megaraid/megaraid_sas_base.c Bjørn Mork                 2012-11-21  8463  	for (i = 0; i < ioc->sge_count; i++) {
3deb9438d34a09 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2016-03-14  8464  		if (kbuff_arr[i]) {
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8465  			if (instance->consistent_mask_64bit)
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8466  				dma_free_coherent(&instance->pdev->dev,
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8467  					le32_to_cpu(kern_sge64[i].length),
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8468  					kbuff_arr[i],
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8469  					le64_to_cpu(kern_sge64[i].phys_addr));
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  8470  			else
9f35fa8a14e621 drivers/scsi/megaraid/megaraid_sas.c      Sumant Patro               2007-02-14  8471  				dma_free_coherent(&instance->pdev->dev,
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8472  					le32_to_cpu(kern_sge32[i].length),
7a6a731bd00ca9 drivers/scsi/megaraid/megaraid_sas_base.c Bjørn Mork                 2012-11-21  8473  					kbuff_arr[i],
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  8474  					le32_to_cpu(kern_sge32[i].phys_addr));
90dc9d98f01bdf drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  8475  			kbuff_arr[i] = NULL;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8476  		}
3deb9438d34a09 drivers/scsi/megaraid/megaraid_sas_base.c Arnd Bergmann              2016-03-14  8477  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8478  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8479  	megasas_return_cmd(instance, cmd);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8480  	return error;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8481  }
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8482  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
