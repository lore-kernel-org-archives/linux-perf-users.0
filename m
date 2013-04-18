From: "Jin, Yao" <yao.jin@intel.com>
Subject: RE: NumaTOP 1.0 launched
Date: Thu, 18 Apr 2013 02:20:02 +0000
Message-ID: <0C6A3B2997299B4EAD81D386F36CD8C20FD91958@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19762 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964828Ab3DRCUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Apr 2013 22:20:07 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "lwn@lwn.net" <lwn@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi, 

https://01.org/numatop/ is slightly faster to access.
Or please access https://github.com/01org/numatop to get the source directly. 

Thanks
Jin Yao

-----Original Message-----
From: Jin, Yao 
Sent: Wednesday, April 17, 2013 10:30 AM
To: 'lwn@lwn.net'; 'linux-kernel@vger.kernel.org'; 'linux-perf-users@vger.kernel.org'
Subject: NumaTOP 1.0 launched

We are pleased to announce today that the NumaTOP project has been added to 01.org. 

Performance analysis engineers know that NUMA can seriously impact performance and that NUMA performance analysis can be challenging. We've realized that currently there isn't an easy-to-use tool that lets us easily observe whether NUMA-related issues exist and, if so, where the NUMA bottleneck(s) reside. It can be quite challenging, especially in complex server environments. 

We decided to create a tool that automatically performs the typical steps in NUMA analysis and provides a good starting point to dive in and fix NUMA-related bottlenecks. That's NumaTOP!

NumaTOP is an observation tool for runtime memory locality characterization and analysis of processes and threads running on a NUMA system. It helps the user characterize the NUMA behavior of processes and threads and identify where the NUMA-related performance bottlenecks reside. It uses Intel performance counter sampling technologies and associates the performance data with system runtime information to provide real-time analysis for production systems.

NumaTOP is a GUI tool. It can run on Linux kernel 3.8 with a perf load latency patch today. That patch is planned to be integrated into kernel 3.9 or a later release.

To learn more about NumaTOP, visit:
http://01.org/numatop/

Best Regards
Jin Yao
