From: William Cohen <wcohen@redhat.com>
Subject: Improving the performance of netdev-times.py script
Date: Fri, 13 Jun 2014 10:54:51 -0400
Message-ID: <539B10BB.3070603@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060602070500040200000800"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbaFMOyw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 Jun 2014 10:54:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5DEspsg005715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2014 10:54:51 -0400
Received: from [10.13.129.83] (dhcp129-83.rdu.redhat.com [10.13.129.83])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5DEspZI028173
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2014 10:54:51 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602070500040200000800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All,

I was experimenting with the perf utils scripts and  I noticed that the netdev-times.py was really slow.  I modified the python script to run Python profiling and found that a lot of time was spent in the handle_skb_copy_datagram_iovec because there can be many many possible entries in rx_skb_list and the code did a linear search through the possible matches.  Python dictionaries use hashing and could be much faster.  I modified rx_skb_list to be a dictionary and the runtime for my example went from 5 minutes down to 11 seconds.

The attached patch shows the changes.  I compared the output between the original perf script and the patched on; there were 8 lines that differed (as shown below), so there is still something not quite correct in the patch.  The output should be identical.  Comments and feedback would be appreciated on this patch.

-Will

[wcohen@santana profiling]$ diff -u /tmp/original /tmp/improved |more
--- /tmp/original	2014-06-12 21:49:51.475501535 -0400
+++ /tmp/improved	2014-06-12 21:44:35.942703446 -0400
@@ -985,8 +985,6 @@
   softirq_entry(+0.010msec)
          |
          |---netif_receive_skb(+0.021msec skb=ffff8803d7d79500 len=50)
-         |            |
-         |      skb_copy_datagram_iovec(+138.745msec 4574:gnome-shell)
          |
          |---netif_receive_skb(+0.044msec skb=ffff8803d7d79500 len=72)
          |            |
@@ -1011,8 +1009,6 @@
   softirq_entry(+0.010msec)
          |
          |---netif_receive_skb(+0.021msec skb=ffff8803b0c25e00 len=50)
-         |            |
-         |      skb_copy_datagram_iovec(+37.385msec 6044:gnome-terminal-)
          |
   napi_poll_exit(+0.047msec em1)
 
@@ -1676,8 +1672,6 @@
   softirq_entry(+0.007msec)
          |
          |---netif_receive_skb(+0.017msec skb=ffff8803d704ff00 len=52)
-         |            |
-         |      skb_copy_datagram_iovec(+556.930msec 1301:Xorg)
          |
   napi_poll_exit(+0.067msec em1)
 
@@ -2475,8 +2469,6 @@
          |---netif_receive_skb(+0.026msec skb=ffff8803b104a800 len=52)
          |
          |---netif_receive_skb(+0.108msec skb=ffff8803b104a800 len=52)
-         |            |
-         |      skb_copy_datagram_iovec(+64.266msec 1301:Xorg)
          |
   napi_poll_exit(+0.125msec em1)
 

--------------060602070500040200000800
Content-Type: text/x-patch;
 name="netdev-times-optim.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="netdev-times-optim.patch"

--- /usr/libexec/perf-core/scripts/python/netdev-times.py	2014-06-07 21:33:33.000000000 -0400
+++ /home/wcohen/libexec/perf-core/scripts/python/netdev-times.py	2014-06-13 09:46:03.809403435 -0400
@@ -23,7 +23,7 @@
 net_rx_dic = {}; # key is cpu and value include time of NET_RX softirq-entry
 		 # and a list which stacks receive
 receive_hunk_list = []; # a list which include a sequence of receive events
-rx_skb_list = []; # received packet list for matching
+rx_skb_list = {}; # received packet list for matching
 		       # skb_copy_datagram_iovec
 
 buffer_budget = 65536; # the budget of rx_skb_list, tx_queue_list and
@@ -387,9 +387,9 @@
 			    'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
 		event_list = net_rx_dic[cpu]['event_list']
 		event_list.append(rec_data)
-		rx_skb_list.insert(0, rec_data)
-		if len(rx_skb_list) > buffer_budget:
-			rx_skb_list.pop()
+		if len(rx_skb_list) < buffer_budget:
+                        rx_skb_list[skbaddr] = rec_data
+                else:
 			of_count_rx_skb_list += 1
 
 def handle_net_dev_queue(event_info):
@@ -435,13 +435,11 @@
 			tx_free_list.append(skb)
 			del tx_xmit_list[i]
 			return
-	for i in range(len(rx_skb_list)):
-		rec_data = rx_skb_list[i]
-		if rec_data['skbaddr'] == skbaddr:
-			rec_data.update({'handle':"kfree_skb",
-					'comm':comm, 'pid':pid, 'comm_t':time})
-			del rx_skb_list[i]
-			return
+	if skbaddr in rx_skb_list.keys():
+                rx_skb_list[skbaddr].update({'handle':"kfree_skb",
+                                 'comm':comm, 'pid':pid, 'comm_t':time})
+                del rx_skb_list[skbaddr]
+                return
 
 def handle_consume_skb(event_info):
 	(name, context, cpu, time, pid, comm, skbaddr) = event_info
@@ -455,10 +453,8 @@
 
 def handle_skb_copy_datagram_iovec(event_info):
 	(name, context, cpu, time, pid, comm, skbaddr, skblen) = event_info
-	for i in range(len(rx_skb_list)):
-		rec_data = rx_skb_list[i]
-		if skbaddr == rec_data['skbaddr']:
-			rec_data.update({'handle':"skb_copy_datagram_iovec",
-					'comm':comm, 'pid':pid, 'comm_t':time})
-			del rx_skb_list[i]
-			return
+	if skbaddr in rx_skb_list.keys():
+		rx_skb_list[skbaddr].update({'handle':"skb_copy_datagram_iovec",
+				'comm':comm, 'pid':pid, 'comm_t':time})
+		del rx_skb_list[skbaddr]
+		return

--------------060602070500040200000800--
