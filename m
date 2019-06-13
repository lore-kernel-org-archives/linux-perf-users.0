From: Paul Clarke <pc@us.ibm.com>
Subject: sys_exit: NR 0 (was "sys_exit: NR -1")
Date: Thu, 13 Jun 2019 16:56:21 -0500
Message-ID: <071af0b8-2386-87d8-ebe0-f1ad6c359de0@us.ibm.com>
References: <2f004b41-4f6f-3e6f-227a-cb199b8429d2@us.ibm.com>
 <1560320989.8h9se8cb9p.naveen@linux.ibm.com>
 <b3d497ac-6e87-c675-3bd3-def0baddf53e@us.ibm.com>
 <96a869bd-c7c5-2f9e-856f-b3b4c0fdf89a@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <96a869bd-c7c5-2f9e-856f-b3b4c0fdf89a@us.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

I'm seeing another asymmetry, this one is on powerpc:
--
  perf 30179 [001] 10374622.667436: raw_syscalls:sys_enter: NR 11 (3fffe16ef55e, [...])
    ls 30179 [002] 10374622.667921:  raw_syscalls:sys_exit: NR 0 = 0
--

Syscall "11" is "execve", but is it expected that the sys_exit will report the ID as 0?  Is that because of the nature of "execve", to overlay the entire contents of the process?

This does not seem to occur on x86.

PC
