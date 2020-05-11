From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Issue in final aggregate value, in case of multiple events
 present in metric expression
Date: Sun, 10 May 2020 17:56:24 -0700
Message-ID: <20200511005624.GL3538@tassilo.jf.intel.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
 <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <6f98d281-f3de-b547-70d4-8fc95515b12f@linux.ibm.com>
 <DB8PR04MB6795DE74059AD3CA8DA7BB5CE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6795DE74059AD3CA8DA7BB5CE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: kajoljain <kjain@linux.ibm.com>, "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, yao.jin@intel.com
List-Id: linux-perf-users.vger.kernel.org

On Sat, May 09, 2020 at 05:52:53AM +0000, Joakim Zhang wrote:
> 
> Hi Arnaldo,
> 
> Kajol reflects this issue for almost two months, got no feedbacks, do you have any comments? That could be appreciated if you can look into it. Thanks a lot!

Jin Yao did a lot of fixes to metrics recently. Does it still happen with
the latest tip tree?

-Andi
